part of 'scoreboardTO_cubit.dart';

class ScoreboardTOState {
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
  Team team1;
  Team team2;
  List<PlayerGame> team1Players;
  List<PlayerGame> team2Players;
  List<CardPlayer> cards;
  Game gameData;
  List<EventLog> eventLogs;

  ScoreboardTOState(
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
      required this.team1Players,
      required this.team2Players,
      required this.cards,
      required this.gameData,
      required this.eventLogs});

  factory ScoreboardTOState.fromJson(Map<String, dynamic> data) {
    final timer = data['timer'];
    final shotclock = data['shotclock'];
    final breakLength = data['breakLength'];
    final periodLength = data['periodLength'];
    final score1 = data['score1'];
    final score2 = data['score2'];
    final period = data['period'];
    final timerRunning = data['timerRunning'];
    final timerShouldRun = data['timerShouldRun'];
    final breakActive = data['breakActive'];
    final shotclockShouldRun = data['shotclockShouldRun'];
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
    final rawPlayers1 = data['team1Players'] as dynamic?;
    final List<dynamic> parsedJson1 = rawPlayers1;
    final List<PlayerGame> team1Players = parsedJson1 != null
        ? parsedJson1.map((e) => PlayerGame.fromJson(e)).toList()
        : <PlayerGame>[];
    final rawPlayers2 = data['team2Players'] as dynamic?;
    final List<dynamic> parsedJson2 = rawPlayers2;
    final List<PlayerGame> team2Players = parsedJson2 != null
        ? parsedJson2.map((e) => PlayerGame.fromJson(e)).toList()
        : <PlayerGame>[];
    final cardData = data['cards'] as dynamic?;
    final List<dynamic> cardParsed = cardData;
    final List<CardPlayer> cards = cardParsed != null
        ? cardParsed.map((e) => CardPlayer.fromJson(e)).toList()
        : <CardPlayer>[];
    final gameDataData = data['gameData'] as dynamic?;
    final gameData = gameDataData != null
        ? Game.fromJson(gameDataData)
        : Game(
            '',
            '',
            Pitch('', '', true, true, ''),
            Division('', '', true, ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            Team('', Division('', '', true, ''), Country('', '', '', ''), '',
                '', false, '', ''),
            0,
            DateTime.now(),
            0,
            0,
            0,
            false,
            true,
            false,
            0,
            '',
            '',
            '');
    final eventLogsData = data['eventLogs'] as dynamic?;
    final List<dynamic> eventLogsParsed = eventLogsData;
    final List<EventLog> eventLogs = eventLogsParsed != null
        ? eventLogsParsed.map(((e) => EventLog.fromJson(e))).toList()
        : <EventLog>[];
    return ScoreboardTOState(
        timer: timer,
        shotclock: shotclock,
        breakLength: breakLength,
        periodLength: periodLength,
        score1: score1,
        score2: score2,
        period: period,
        timerRunning: parseBool(timerRunning),
        timerShouldRun: parseBool(timerShouldRun),
        breakActive: parseBool(breakActive),
        shotclockShouldRun: parseBool(shotclockShouldRun),
        team1: team1,
        team2: team2,
        team1Players: team1Players,
        team2Players: team2Players,
        cards: cards,
        gameData: gameData,
        eventLogs: eventLogs);
  }
  Map<String, dynamic> toJson() {
    return {
      'timer': timer,
      'shotclock': shotclock,
      'breakLength': breakLength,
      'periodLength': periodLength,
      'score1': score1,
      'score2': score2,
      'period': period,
      'timerRunning': timerRunning.toString(),
      'timerShouldRun': timerShouldRun.toString(),
      'breakActive': breakActive.toString(),
      'shotclockShouldRun': shotclockShouldRun.toString(),
      'team1': team1.toJson(),
      'team2': team2.toJson(),
      'team1Players': team1Players.map((e) => e.toJson()).toList(),
      'team2Players': team2Players.map((e) => e.toJson()).toList(),
      'cards': cards.map((e) => e.toJson()).toList(),
      'gameData': gameData.toJson(),
      'eventLogs': eventLogs.map((e) => e.toJson()).toList()
    };
  }
}

class ScoreboardTOInitial extends ScoreboardTOState {
  ScoreboardTOInitial()
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
            team1: Team('', Division('', '', true, ''), Country('', '', '', ''),
                '', '', false, '', ''),
            team2: Team('', Division('', '', true, ''), Country('', '', '', ''),
                '', '', false, '', ''),
            team1Players: [],
            team2Players: [],
            cards: [],
            gameData: Game(
                '',
                '',
                Pitch('', '', true, true, ''),
                Division('', '', true, ''),
                Team('', Division('', '', true, ''), Country('', '', '', ''),
                    '', '', false, '', ''),
                Team('', Division('', '', true, ''), Country('', '', '', ''),
                    '', '', false, '', ''),
                Team('', Division('', '', true, ''), Country('', '', '', ''),
                    '', '', false, '', ''),
                0,
                DateTime.now(),
                0,
                0,
                0,
                false,
                true,
                false,
                0,
                '',
                '',
                ''),
            eventLogs: []);
}
