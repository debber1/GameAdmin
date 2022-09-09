import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:gameadmin/models/team.dart';

import 'country.dart';
import 'division.dart';

class CardPlayer {
  PlayerGame player;
  int timeLeft;
  int card;
  factory CardPlayer.fromJson(Map<String, dynamic> data) {
    final playerData = data['player'] as dynamic?;
    final player = playerData != null
        ? PlayerGame.fromJson(playerData)
        : PlayerGame(
            '',
            Player(
                '',
                Team('', Division('', '', true, ''), Country('', '', '', ''),
                    '', '', false, '', ''),
                0,
                '',
                '',
                false),
            0,
            0,
            0,
            0,
            0);
    final timeLeft = int.parse(data['timeLeft']) as int;
    final card = int.parse(data['card']) as int;
    return CardPlayer(player, timeLeft, card);
  }
  Map<String, dynamic> toJson() {
    return {
      'player': player.toJson(),
      'timeLeft': timeLeft.toString(),
      'card': card.toString()
    };
  }

  CardPlayer(this.player, this.timeLeft, this.card);
}
