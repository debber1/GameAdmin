import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/util/func.dart';

class Team {
  String id;
  Division division;
  Country country;
  String name;
  String language;
  bool forfaitTeam;
  String pfdColour1;
  String pfdColour2;
  factory Team.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    if (id == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "id" is missing');
    }

    final divisionData = data['division'] as dynamic?;
    final division = divisionData != null
        ? Division.fromJson(divisionData)
        : Division('', '', true, '');

    final countryData = data['country'] as dynamic?;
    final country = countryData != null
        ? Country.fromJson(countryData)
        : Country('', '', '', '');

    final name = data['name'] as String;
    if (name == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "name" is missing');
    }

    final language = data['language'] as String;
    if (language == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "language" is missing');
    }

    final forfaitTeam = parseBool(data['forfaitTeam']) as bool;
    if (forfaitTeam == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "forfaitTeam" is missing');
    }

    final pfdColour1 = data['pfdColour1'] as String;
    if (pfdColour1 == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "pfdColour1" is missing');
    }

    final pfdColour2 = data['pfdColour2'] as String;
    if (pfdColour2 == null) {
      // Data vallidation
      throw UnsupportedError('Invalid data: $data -> "pfdColour2" is missing');
    }

    return Team(id, division, country, name, language, forfaitTeam, pfdColour1,
        pfdColour2);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'division': division.toJson(),
      'country': country.toJson(),
      'name': name,
      'language': language,
      'forfaitTeam': forfaitTeam.toString(),
      'pfdColour1': pfdColour1,
      'pfdColour2': pfdColour2,
    };
  }

  Team(this.id, this.division, this.country, this.name, this.language,
      this.forfaitTeam, this.pfdColour1, this.pfdColour2);
}
