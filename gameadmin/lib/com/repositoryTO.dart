import 'dart:convert';

import 'package:gameadmin/com/networkServiceTO.dart';
import 'package:gameadmin/com/repositorySB.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:gameadmin/models/return_data.dart';

import '../models/game.dart';
import '../models/pitch.dart';

class RepositoryTO {
  final NetworkServiceTO networkServiceTO;
  RepositoryTO(this.networkServiceTO);

  Future<List<Game>> fetchGames(String pitchId) async {
    final rawData = await networkServiceTO.fetchGames(pitchId);
    final List<dynamic> parsedJson = jsonDecode(rawData);
    final List<Game> games = parsedJson != null ? parsedJson.map((e) => Game.fromJson(e)).toList() : <Game>[];
    return games;
  }

  Future<List<Pitch>> fetchPitch(String tournamentID) async {
    final rawPitch = await networkServiceTO.fetchPitch(tournamentID);
    final List<dynamic> parsedJson = jsonDecode(rawPitch);
    final List<Pitch> pitches = parsedJson != null ? parsedJson.map((e) => Pitch.fromJson(e)).toList() : <Pitch>[];
    return pitches;
  }

  Future<List<List<PlayerGame>>> fetchPlayers(List<String> ids) async {
    List<List<PlayerGame>> players = [];
    for (var id in ids) {
      final rawPlayers = await networkServiceTO.fetchPlayers(id);
      final List<dynamic> parsedJson = jsonDecode(rawPlayers);
      final List<PlayerGame> player = parsedJson != null ? parsedJson.map((e) => PlayerGame.fromJson(e)).toList() : <PlayerGame>[];
      players.add(player);
    }
    return players;
  }

  Future<dynamic> pushResult(ReturnData returnData) async {
    final status = await networkServiceTO.pushResult(jsonEncode(returnData.toJson()));
    return status;
  }

  void syncScoreBoard(int playTime, int shotTime, int scoreBlue, int scoreRed, Pitch pitch) async {
    networkServiceTO.syncScoreBoard(jsonEncode(buildJson(playTime, shotTime, scoreBlue, scoreRed)), pitch.scoreIP);
  }

  /// Make and start the connection with a tcp target
  /// * @param: ip: The IP of the target
  void initTcpConnection(Pitch pitch) async {
    if (!await networkServiceTO.changeTcpIP(pitch.scoreIP)) {
      print("Problem with connection");
    }
  }

  /// Send the status update to the tcp target
  /// * @param: data: The data for the target
  void statusUpdateScoreBoard(int playTime, int shotTime, int scoreBlue, int scoreRed) async {
    String data = jsonEncode(buildJson(playTime, shotTime, scoreBlue, scoreRed));
    networkServiceTO.sendStatusUpdate(data);
  }
}
