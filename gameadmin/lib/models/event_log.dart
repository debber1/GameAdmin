import 'package:flutter/foundation.dart';
import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/player_game.dart';

class EventLog {
  int gameTime;
  int gamePeriod;
  DateTime deviceTime;
  int eventCode;
  String description;
  Player player;
  /*
  eventCode meaning:
  1: scoring a goal
  2: removing scored goal
  3: adding green card
  4: removing green card
  5: adding yellow card
  6: removing yellow card
  7: adding red card
  8: removing yellow card
  9: adding red ejection card
  10: removing red ejection card
  */

  EventLog(this.gameTime, this.gamePeriod, this.deviceTime, this.eventCode,
      this.description, this.player);

  factory EventLog.fromJson(Map<String, dynamic> data) {
    final gameTime = int.parse(data['gameTime']) as int;
    final gamePeriod = int.parse(data['gamePeriod']) as int;
    final deviceTime = DateTime.parse(data['deviceTime']) as DateTime;
    final eventCode = int.parse(data['eventCode']) as int;
    final description = data['description'] as String;
    final playerData = data['player'] as dynamic?;
    final player = Player.fromJson(playerData);

    return EventLog(
        gameTime, gamePeriod, deviceTime, eventCode, description, player);
  }
  Map<String, dynamic> toJson() {
    return {
      'gameTime': gameTime.toString(),
      'gamePeriod': gamePeriod.toString(),
      'deviceTime': deviceTime.toString(),
      'eventCode': eventCode.toString(),
      'description': description,
      'player': player.toJson()
    };
  }
}
