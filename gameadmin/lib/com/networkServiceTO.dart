import 'dart:convert';
import 'dart:io';

import 'package:gameadmin/util/server.dart';
import 'package:http/http.dart';

class NetworkServiceTO {
  final String baseUrl = urlTO;

  Future<dynamic> fetchPitch() async {
    final url = Uri.parse('$baseUrl/pitch.php');
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
    };
    final json = '{"pitchNumber":"1"}';
    final response = await post(url, headers: headers, body: json);
    final String rep = response.body;
    return (jsonDecode(response.body));
  }
}
