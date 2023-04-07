import 'dart:io';

import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/util/server.dart';
import 'package:http/http.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class NetworkServiceTO {
  final String baseUrl = urlTO;
  TcpSocketConnection persistantTcpSocketConnection = TcpSocketConnection("0.0.0.0", 10000);

  /// Open the connection to the persistantTcpSocketConnection
  Future<bool> openTcpConnection() async {
    // Check if it's possible to connect to the endpoint
    if (await persistantTcpSocketConnection.canConnect(5000, attempts: 3)) {
      //If a connection is possible, open it and return true
      try {
        persistantTcpSocketConnection = await persistantTcpSocketConnection.connect(1000, recieveMessage, attempts: 3);
        return true;
      } catch (e) {
        return false;
      }
    }
    // If the connection is not possible, return false
    return false;
  }

  /// Change the IP address of the persistantTcpSocketConnection target, then reopen the connection
  ///  * @param ip: The new IP address of the target
  Future<bool> changeTcpIP(String? ip) async {
    if (ip == null) {
      return false;
    }
    // First disconnect from the previous connection
    disconnectTcp();
    // Start new connection
    persistantTcpSocketConnection = TcpSocketConnection(ip, 10000);
    return await openTcpConnection();
  }

  /// Disconnect from the TCP target
  void disconnectTcp() {
    // Check for connection
    if (persistantTcpSocketConnection.isConnected()) {
      // Disconnect
      persistantTcpSocketConnection.disconnect();
    }
  }

  /// Send a string of data to the tcp target
  /// * @param data: The date which you want to send to the target
  bool sendStatusUpdate(String data) {
    //Check for connection
    if (persistantTcpSocketConnection.isConnected()) {
      try {
        persistantTcpSocketConnection.sendMessage(data);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<String> fetchGames(String pitchId) async {
    try {
      final url = Uri.parse('$baseUrl/games.php');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
      final json = '{"pitchId":"' + pitchId + '"}';
      final response = await post(url, headers: headers, body: json);
      return (response.body);
    } catch (e) {
      return '';
    }
  }

  Future<dynamic> fetchPitch(String tournamentId) async {
    try {
      final url = Uri.parse('$baseUrl/pitch.php');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
      final json = '{"tournamentId":"' + tournamentId + '"}';
      final response = await post(url, headers: headers, body: json);
      final String rep = response.body;
      return (rep);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> fetchPlayers(String id) async {
    try {
      final url = Uri.parse('$baseUrl/detail.php');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
      final json = '{"teamId":"' + id + '"}';
      final response = await post(url, headers: headers, body: json);
      final String rep = response.body;
      return (rep);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> pushResult(String data) async {
    try {
      final url = Uri.parse('$baseUrl/gameResult.php');
      final headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'};
      final response = await post(url, headers: headers, body: data);
      return response.statusCode;
    } catch (e) {
      return (HttpStatus.conflict);
    }
  }

  void syncScoreBoard(String data, String? scoreIP) async {
    if (scoreIP != null) {
      try {
        TcpSocketConnection tcpSocketConnection = TcpSocketConnection("192.168.1.113", 10000);
        if (await tcpSocketConnection.canConnect(5000, attempts: 3)) {
          //check if it's possible to connect to the endpoint
          final connection = await tcpSocketConnection.connect(5000, recieveMessage, attempts: 3);
          tcpSocketConnection.sendMessage(data);
          tcpSocketConnection.disconnect();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void recieveMessage(String msg) {
    print(msg);
  }
}
