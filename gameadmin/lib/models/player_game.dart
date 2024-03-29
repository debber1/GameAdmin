import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/team.dart';

class PlayerGame {
  String id;
  Player player;
  int goals;
  int green;
  int yellow;
  int red;
  int redEjection;
  factory PlayerGame.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }
    var goals;
    try {
      goals = int.parse(data['goals']) as int;
    } catch (e) {}
    if (goals == null) {
      goals = 0;
    }
    final playerData = data['player'] as dynamic?;
    final player = playerData != null
        ? Player.fromJson(playerData)
        : Player(
            '',
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            1,
            '',
            '',
            false);

    final green = int.parse(data['green']) as int;
    if (green == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "green" is missing');
    }

    final yellow = int.parse(data['yellow']) as int;
    if (yellow == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "yellow" is missing');
    }

    final red = int.parse(data['red']) as int;
    if (red == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "red" is missing');
    }

    final redEjection = int.parse(data['redEjection']) as int;
    if (redEjection == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "redEjection" is missing');
    }

    return PlayerGame(id, player, goals, green, yellow, red, redEjection);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player': player.toJson(),
      'goals': goals.toString(),
      'green': green.toString(),
      'yellow': yellow.toString(),
      'red': red.toString(),
      'redEjection': redEjection.toString(),
    };
  }

  PlayerGame(this.id, this.player, this.goals, this.green, this.yellow,
      this.red, this.redEjection);
}
