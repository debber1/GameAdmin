import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/team.dart';
import 'package:gameadmin/util/func.dart';

class Player {
  String id;
  Team team;
  int number;
  String firstName;
  String lastName;
  bool captain;
  factory Player.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }

    final teamData = data['team'] as dynamic?;
    final team = teamData != null
        ? Team.fromJson(teamData)
        : Team('', Division('', '', true, ''), Country('', '', '', ''), '', '',
            false, '', '');

    final number = data['number'] as int;
    if (number == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "number" is missing');
    }

    final firstName = data['firstName'] as String;
    if (firstName == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "firstName" is missing');
    }

    final lastName = data['lastName'] as String;
    if (lastName == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "lastName" is missing');
    }

    final captain = data['captain'];
    if (captain == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "captain" is missing');
    }

    return Player(id, team, number, firstName, lastName, captain);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team': team.toJson(),
      'number': number,
      'firstName': firstName,
      'lastName': lastName,
      'captain': captain,
    };
  }

  Player(this.id, this.team, this.number, this.firstName, this.lastName,
      this.captain);
}
