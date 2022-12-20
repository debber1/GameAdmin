import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/team.dart';
import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/util/func.dart';

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
  String? positionRef;
  String? gameRef;
  factory Game.fromJson(Map<String, dynamic> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }

    final tournamentName = data['tournamentName'] as String;
    if (tournamentName == null) {
      // Data vallidation
      throw UnsupportedError(
          'Invalid data: $data -> "tournamentName" is missing');
    }

    final pitchData = data['pitch'] as dynamic?;
    final pitch = pitchData != null
        ? Pitch.fromJson(pitchData)
        : Pitch('', '', true, true, '', '');

    final divisionData = data['division'] as dynamic?;
    final division = divisionData != null
        ? Division.fromJson(divisionData)
        : Division('', '', true, '');

    final team1Data = data['team1'] as dynamic?;
    final team1 = team1Data != null
        ? Team.fromJson(team1Data)
        : Team('', Division('', '', true, ''), Country('', '', '', ''), '', '',
            false, '', '');

    final team2Data = data['team2'] as dynamic?;
    final team2 = team2Data != null
        ? Team.fromJson(team2Data)
        : Team('', Division('', '', true, ''), Country('', '', '', ''), '', '',
            false, '', '');

    final teamRefData = data['teamRef'] as dynamic?;
    final teamRef = teamRefData != null
        ? Team.fromJson(teamRefData)
        : Team('', Division('', '', true, ''), Country('', '', '', ''), '', '',
            false, '', '');

    final gameNumber = int.parse(data['gameNumber']) as int;
    if (gameNumber == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "gameNumber" is missing');
    }

    final time = DateTime.parse(data['time']) as DateTime;
    if (time == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "time" is missing');
    }

    final timeFollowNumber = int.parse(data['timeFollowNumber']) as int;
    if (timeFollowNumber == null) {
      // Data vallidation
      throw UnsupportedError(
          'Invalid data: $data -> "timeFollowNumber" is missing');
    }

    final scoreTeam1 = int.parse(data['scoreTeam1']) as int;
    if (scoreTeam1 == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "scoreTeam1" is missing');
    }

    final scoreTeam2 = int.parse(data['scoreTeam2']) as int;
    if (scoreTeam2 == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "scoreTeam2" is missing');
    }

    final played = parseBool(data['played']) as bool;
    if (played == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "played" is missing');
    }

    final drawAllowed = parseBool(data['drawAllowed']) as bool;
    if (drawAllowed == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "drawAllowed" is missing');
    }

    final forfait = parseBool(data['forfait']) as bool;
    if (forfait == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "forfait" is missing');
    }

    final round = int.parse(data['round']) as int;
    if (round == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "round" is missing');
    }

    final idGroupRef = data['idGroupRef'] as String;
    if (idGroupRef == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "idGroupRef" is missing');
    }

    final positionRef = data['positionRef'] as String;
    if (positionRef == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "positionRef" is missing');
    }

    final gameRef = data['gameRef'] as String;
    if (gameRef == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "gameRef" is missing');
    }

    return Game(
        id,
        tournamentName,
        pitch,
        division,
        team1,
        team2,
        teamRef,
        gameNumber,
        time,
        timeFollowNumber,
        scoreTeam1,
        scoreTeam2,
        played,
        drawAllowed,
        forfait,
        round,
        idGroupRef,
        positionRef,
        gameRef);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tournamentName': tournamentName,
      'pitch': pitch.toJson(),
      'division': division.toJson(),
      'team1': team1.toJson(),
      'team2': team2.toJson(),
      'teamRef': teamRef.toJson(),
      'gameNumber': gameNumber.toString(),
      'time': time.toString(),
      'timeFollowNumber': timeFollowNumber.toString(),
      'scoreTeam1': scoreTeam1.toString(),
      'scoreTeam2': scoreTeam2.toString(),
      'played': played.toString(),
      'drawAllowed': drawAllowed.toString(),
      'forfait': forfait.toString(),
      'round': round.toString(),
      'idGroupRef': idGroupRef,
      'positionRef': positionRef,
      'gameRef': gameRef,
    };
  }

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
