import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/pitch.dart';

void main() {
  group('Server data parsing', () {
    /// Tests the data parsing functions for a list of games
    test('games.php -- Perfect data', () {
      // Loading the test data
      String perfectData =
          '[{ "id":"3ae2ec91-c196-4ef2-9de0-92e7f98cd16b", "tournamentName":"Test Tournament", "pitch":{"id":"427f08ed-643d-45cd-b3ef-dd20c6c46c68", "name":"Pitch 1", "shotClock": "true", "finalePitch": "true", "pitchResponsable": "John Doe", "scoreIP": "192.168.1.1"}, "division": {"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5", "name":"Division 1", "shotClock":"true", "shortName":"DIV1"}, "team1":{"id":"84af1e04-f27d-48a5-ab01-9249d2561e28", "division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5", "name":"Division 1", "shotClock":"true", "shortName":"DIV1"}, "country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"}, "name":"Team Tof", "language":"Dutch","forfaitTeam":"false", "pfdColour1":"Red","pfdColour2":"Yellow"}, "team2":{"id":"c6f9cebe-11ad-41fe-a704-3eb3d1772612", "division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5", "name":"Division 1", "shotClock":"true", "shortName":"DIV1"}, "country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"}, "name":"Team Supertof", "language":"Dutch","forfaitTeam":"false", "pfdColour1":"Blue","pfdColour2":"Black"}, "teamRef":{"id":"28918246-fbd5-43ff-bbef-390b950b1981", "division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5", "name":"Division 1", "shotClock":"true", "shortName":"DIV1"}, "country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"}, "name":"Team Megatof", "language":"Dutch","forfaitTeam":"false", "pfdColour1":"Orange","pfdColour2":"Pink"}, "gameNumber": "1", "time":"2000-05-10 22:19:23", "timeFollowNumber": "1", "scoreTeam1": "0", "scoreTeam2":"0","played":"false","drawAllowed":"true","forfait":"false","round":"1","idGroupRef":"db801592-8ed4-4fb0-bf97-04c1f859b788", "positionRef":"d6a906bf-b4fe-46c4-ac18-902c9b1713bd","gameRef":"a274bd32-807d-448b-bf03-e5b40ad46d24"},{"id":"5a6d669b-e12a-4fb7-aaa7-cffc9465e2e6","tournamentName":"Test Tournament","pitch":{"id":"427f08ed-643d-45cd-b3ef-dd20c6c46c68","name":"Pitch 1","shotClock":"true","finalePitch":"true","pitchResponsable":"John Doe", "scoreIP": "192.168.1.1"},"division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5","name":"Division 1","shotClock":"true","shortName":"DIV1"},"team1":{"id":"31fb42ca-e26b-4dcd-b810-e829c1a3f176","division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5","name":"Division 1","shotClock":"true","shortName":"DIV1"},"country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"},"name":"Team lol","language":"Dutch","forfaitTeam":"false","pfdColour1":"Yellow","pfdColour2":"Red"},"team2":{"id":"77e65a1f-0e48-4aae-9021-8a5885155c26","division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5","name":"Division 1","shotClock":"true","shortName":"DIV1"},"country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"},"name":"Team lmao","language":"Dutch","forfaitTeam":"false","pfdColour1":"Black","pfdColour2":"Blue"},"teamRef":{"id":"c656278e-c396-497b-9df5-d0fbccc14ee2","division":{"id":"3c69d40f-85d1-4940-a46a-4c05b1181ab5","name":"Division 1","shotClock":"true","shortName":"DIV1"},"country":{"id":"b65824fe-9a09-4beb-9082-017d65dcac5c","code":"BE","name":"Belgium","flag":"https://www.rectusoft.com/app_depaddel/vlag/belgium.png"},"name":"Team iirc","language":"Dutch","forfaitTeam":"false","pfdColour1":"Pink","pfdColour2":"Orange"},"gameNumber":"2","time":"2000-05-10 23:19:23","timeFollowNumber":"2","scoreTeam1":"0","scoreTeam2":"0","played":"false","drawAllowed":"false","forfait":"false","round":"2","idGroupRef":"db801592-8ed4-4fb0-bf97-04c1f859b788","positionRef":"288b60d5-86b0-4b39-856b-328482092bb0","gameRef":"e8a87291-049f-4f19-9ffb-eb001b62993b"}]';
      // Converting the data to a list of games
      final List<dynamic> parsedJson = jsonDecode(perfectData);
      final List<Game> games = parsedJson != null
          ? parsedJson.map((e) => Game.fromJson(e)).toList()
          : <Game>[];
      // There should be 2 games loaded
      expect(games.length, 2);

      // Check the id's
      expect(games[0].id, "3ae2ec91-c196-4ef2-9de0-92e7f98cd16b");
      expect(games[1].id, "5a6d669b-e12a-4fb7-aaa7-cffc9465e2e6");

      // check if the pitches got processed correctly
      Pitch testPitch = Pitch("427f08ed-643d-45cd-b3ef-dd20c6c46c68", "Pitch 1",
          true, true, "John Doe", "192.168.1.1");
      expect(games[0].pitch.finalePitch, testPitch.finalePitch);
      expect(games[0].pitch.id, testPitch.id);
      expect(games[0].pitch.name, testPitch.name);
      expect(games[0].pitch.scoreIP, testPitch.scoreIP);
      expect(games[0].pitch.shotClock, testPitch.shotClock);
      expect(games[0].pitch.pitchResponsable, testPitch.pitchResponsable);
      expect(games[1].pitch.finalePitch, testPitch.finalePitch);
      expect(games[1].pitch.id, testPitch.id);
      expect(games[1].pitch.name, testPitch.name);
      expect(games[1].pitch.scoreIP, testPitch.scoreIP);
      expect(games[1].pitch.shotClock, testPitch.shotClock);
      expect(games[1].pitch.pitchResponsable, testPitch.pitchResponsable);
    });
  });
}
