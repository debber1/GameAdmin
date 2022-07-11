import 'dart:convert';

import 'package:gameadmin/com/networkServiceTO.dart';
import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/player_game.dart';

import '../models/game.dart';
import '../models/pitch.dart';

class RepositoryTO {
  final NetworkServiceTO networkServiceTO;
  RepositoryTO(this.networkServiceTO);
  Future<List<Game>> fetchGames(String pitchId) async {
    final rawData = await networkServiceTO.fetchGames(pitchId);
    final List<dynamic> parsedJson = jsonDecode(rawData);
    final List<Game> games = parsedJson != null
        ? parsedJson.map((e) => Game.fromJson(e)).toList()
        : <Game>[];
    return games;
  }

  Future<Pitch> fetchPitch(int pitchNumber) async {
    final rawPitch = await networkServiceTO.fetchPitch(pitchNumber);
    return Pitch.fromJson(rawPitch);
  }

  Future<List<List<PlayerGame>>> fetchPlayers(List<String> ids) async {
    List<List<PlayerGame>> players = [];
    for (var id in ids) {
      final rawPlayers = await networkServiceTO.fetchPlayers(id);
      final List<dynamic> parsedJson = jsonDecode(rawPlayers);
      final List<PlayerGame> player = parsedJson != null
          ? parsedJson.map((e) => PlayerGame.fromJson(e)).toList()
          : <PlayerGame>[];
      players.add(player);
    }
    return players;
  }
}
