import 'dart:io';

import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/util/server.dart';
import 'package:http/http.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class NetworkServiceTO {
  final String baseUrl = urlTO;

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
        TcpSocketConnection tcpSocketConnection = TcpSocketConnection(scoreIP, 10000);
        if (await tcpSocketConnection.canConnect(500, attempts: 2)) {
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
