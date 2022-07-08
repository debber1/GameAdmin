import 'dart:convert';

import 'package:gameadmin/com/networkServiceTO.dart';

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
}
