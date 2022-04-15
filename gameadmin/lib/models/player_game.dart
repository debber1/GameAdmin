import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/player.dart';

class PlayerGame {
  String id;
  Player player;
  Game game;
  int green;
  int yellow;
  int red;
  int redEjection;

  PlayerGame(this.id, this.player, this.game, this.green, this.yellow, this.red,
      this.redEjection);
}
