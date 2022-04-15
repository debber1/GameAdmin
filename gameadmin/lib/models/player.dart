import 'package:gameadmin/models/team.dart';

class Player {
  String id;
  Team team;
  int number;
  String firstName;
  String lastName;
  bool captain;

  Player(this.id, this.team, this.number, this.firstName, this.lastName,
      this.captain);
}
