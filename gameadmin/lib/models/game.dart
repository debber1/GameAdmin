import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/team.dart';
import 'package:gameadmin/models/pitch.dart';

class Game {
  String id;
  String tournamentName;
  Pitch pitch;
  Division division;
  Team team1;
  Team team2;
  Team teamRef;
  int gameNumber;
  DateTime time;
  int timeFollowNumber;
  int scoreTeam1;
  int scoreTeam2;
  bool? played;
  bool drawAllowed;
  bool forfait;
  int? round;
  String? idGroupRef;
  int? positionRef;
  String? gameRef;

  Game(
      this.id,
      this.tournamentName,
      this.pitch,
      this.division,
      this.team1,
      this.team2,
      this.teamRef,
      this.gameNumber,
      this.time,
      this.timeFollowNumber,
      this.scoreTeam1,
      this.scoreTeam2,
      this.played,
      this.drawAllowed,
      this.forfait,
      this.round,
      this.idGroupRef,
      this.positionRef,
      this.gameRef);
}
