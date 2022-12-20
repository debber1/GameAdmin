import 'dart:convert';

import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/event_log.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:gameadmin/models/team.dart';

class ReturnData {
  Game game;
  List<PlayerGame> team1;
  List<PlayerGame> team2;
  List<EventLog> eventLogs;

  factory ReturnData.fromJson(Map<String, dynamic> data) {
    final gameData = data['game'] as dynamic?;
    final game = gameData != null
        ? Game.fromJson(gameData)
        : Game(
            '',
            '',
            Pitch('', '', true, true, '', ''),
            Division('', '', true, ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            0,
            DateTime.now(),
            0,
            0,
            0,
            false,
            true,
            false,
            0,
            '',
            '',
            '');

    final rawPlayers1 = data['team1'] as String;
    final List<dynamic> parsedJson1 = jsonDecode(rawPlayers1);
    final List<PlayerGame> team1 = parsedJson1 != null
        ? parsedJson1.map((e) => PlayerGame.fromJson(e)).toList()
        : <PlayerGame>[];
    final rawPlayers2 = data['team2'] as String;
    final List<dynamic> parsedJson2 = jsonDecode(rawPlayers2);
    final List<PlayerGame> team2 = parsedJson2 != null
        ? parsedJson2.map((e) => PlayerGame.fromJson(e)).toList()
        : <PlayerGame>[];
    final eventLogsData = data['eventLogs'] as dynamic?;
    final List<dynamic> eventLogsParsed = eventLogsData;
    final List<EventLog> eventLogs = eventLogsParsed != null
        ? eventLogsParsed.map(((e) => EventLog.fromJson(e))).toList()
        : <EventLog>[];
    return ReturnData(game, team1, team2, eventLogs);
  }

  Map<String, dynamic> toJson() {
    return {
      'game': game.toJson(),
      'team1': team1.map((e) => e.toJson()).toList(),
      'team2': team2.map((e) => e.toJson()).toList(),
      'eventLogs': eventLogs.map((e) => e.toJson()).toList()
    };
  }

  ReturnData(this.game, this.team1, this.team2, this.eventLogs);
}
