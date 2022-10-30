import 'dart:convert';

Map<String, dynamic> buildJson(
    int playTime, int shotTime, int scoreBlue, int scoreRed) {
  return {'board': buildBoard(playTime, shotTime, scoreBlue, scoreRed)};
}

Map<String, dynamic> buildBoard(
    int playTime, int shotTime, int scoreBlue, int scoreRed) {
  return {
    'time': buildTime(playTime, shotTime),
    'score': buildScore(scoreBlue, scoreRed),
    'faults': buildFaults()
  };
}

List buildTime(int playTime, int shotTime) {
  Map<String, dynamic> temp = {
    'play_time': playTime.toString(),
    'shot_time': shotTime.toString()
  };
  return [temp];
}

List buildScore(int scoreBlue, int scoreRed) {
  Map<String, dynamic> temp = {
    'blue': scoreBlue.toString(),
    'red': scoreRed.toString()
  };
  return [temp];
}

List buildFaults() {
  Map<String, dynamic> temp = {'blue': 0.toString(), 'red': 0.toString()};
  return [temp];
}
