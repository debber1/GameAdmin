import 'dart:io';
import 'dart:convert';

import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/util/server.dart';
import 'package:http/http.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class NetworkServiceTO {
  final String baseUrl = urlTO;

  Future<String> fetchGames(String pitchId) async {
    try {
      //final url = Uri.parse('$baseUrl/games');
      final url = Uri.parse('$baseUrl/games.php');
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };
      final json = '{"pitchId":"' + pitchId + '"}';
      final response = await post(url, headers: headers, body: json);
      return (utf8.decode(response.body.codeUnits));
    } catch (e) {
      return '';
    }
  }

  Future<dynamic> fetchPitch(String tournamentId) async {
    try {
      // final url = Uri.parse('$baseUrl/pitch');
      final url = Uri.parse('$baseUrl/pitch.php');
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };
      final json = '{"tournamentId":"' + tournamentId + '"}';
      final response = await post(url, headers: headers, body: json);
      final String rep = (utf8.decode(response.body.codeUnits));
      return (rep);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> fetchPlayers(String id) async {
    try {
      //final url = Uri.parse('$baseUrl/detail');
      final url = Uri.parse('$baseUrl/detail.php');
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };
      final json = '{"teamID":"' + id + '"}';
      final response = await post(url, headers: headers, body: json);
      final String rep = (utf8.decode(response.body.codeUnits));
      return (rep);
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> pushResult(String data) async {
    try {
      //final url = Uri.parse('$baseUrl/gameResult');
      final url = Uri.parse('$baseUrl/gameResult.php');
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };
      final response = await post(url, headers: headers, body: data);
      return response.statusCode;
    } catch (e) {
      return (HttpStatus.conflict);
    }
  }

  void syncScoreBoard(String datagram, String? scoreIP) async {
    if (scoreIP != null) {
      try {
        var DESTINATION_ADDRESS = InternetAddress(scoreIP);

        RawDatagramSocket.bind(InternetAddress.anyIPv4, 10000)
            .then((RawDatagramSocket udpSocket) {
          udpSocket.broadcastEnabled = false;
          List<int> data = utf8.encode(datagram);
          udpSocket.send(data, DESTINATION_ADDRESS, 10000);
        });
/*         TcpSocketConnection tcpSocketConnection = TcpSocketConnection(scoreIP, 10000);
        if (await tcpSocketConnection.canConnect(250, attempts: 1)) {
          //check if it's possible to connect to the endpoint
          final connection = await tcpSocketConnection.connect(5000, recieveMessage, attempts: 3);
          tcpSocketConnection.sendMessage(data);
          tcpSocketConnection.disconnect();
        } */
      } catch (e) {
        print(e);
      }
    }
  }

  void recieveMessage(String msg) {
    print(msg);
  }
}
