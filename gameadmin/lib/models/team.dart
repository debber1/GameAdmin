import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/country.dart';

class Team {
  String id;
  Division division;
  Country country;
  String name;
  String language;
  bool forfaitTeam;
  String pfdColour1;
  String pfdColour2;

  Team(this.id, this.division, this.country, this.name, this.language,
      this.forfaitTeam, this.pfdColour1, this.pfdColour2);
}
