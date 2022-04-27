part of 'scoreboard_cubit.dart';

class ScoreboardState {
  int timer; //in seconds
  int shotclock; //in seconds
  int breakLength; //in minutes
  int periodLength; // in minutes
  int score1;
  int score2;
  int period;
  bool timerRunning;
  bool timerShouldRun;
  bool breakActive;
  bool shotclockShouldRun;
  String team1;
  String team2;
  Color team1Colour;
  Color team2Colour;
  ScoreboardState(
      {required this.timer,
      required this.shotclock,
      required this.breakLength,
      required this.periodLength,
      required this.score1,
      required this.score2,
      required this.period,
      required this.timerRunning,
      required this.timerShouldRun,
      required this.breakActive,
      required this.shotclockShouldRun,
      required this.team1,
      required this.team2,
      required this.team1Colour,
      required this.team2Colour});
}

class ScoreboardInitial extends ScoreboardState {
  ScoreboardInitial()
      : super(
            timer: 600,
            shotclock: 60,
            breakLength: 2,
            periodLength: 10,
            score1: 0,
            score2: 0,
            period: 1,
            timerRunning: false,
            timerShouldRun: false,
            breakActive: false,
            shotclockShouldRun: false,
            team1: "Team A",
            team2: "Team B",
            team1Colour: Colors.blue,
            team2Colour: Colors.red);
}

//class ScoreboardProgress extends ScoreboardState {}
