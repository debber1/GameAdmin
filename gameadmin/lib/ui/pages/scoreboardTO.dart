import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/scoreboardTO_cubit.dart';
import 'package:gameadmin/models/card.dart';
import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:gameadmin/models/team.dart';

class ScoreBoardTO extends StatelessWidget {
  ScoreBoardTO({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScoreboardTOCubit>(context).shotclockTimer();
    BlocProvider.of<ScoreboardTOCubit>(context).mainTimer();
    BlocProvider.of<ScoreboardTOCubit>(context).setstate();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'GameAdmin',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: AppBar(
            title: Text('GameAdmin - github.com/debber1/GameAdmin -- TO MODE'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (choice) => handleClick(choice, context),
                itemBuilder: (BuildContext context) {
                  return {
                    'Reset timer',
                    'Reset game',
                    'Switch sides',
                    'Back to settings'
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
        body: BlocBuilder<ScoreboardTOCubit, ScoreboardTOState>(
          builder: (context, state) {
            return Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 2, child: Container()), //spacing on the left side
                  Expanded(
                    flex: 50,
                    child: Container(
                      //First column of three
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  state.team1.country.flag)),
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 5),
                                        child: Text(
                                          state.team1.name,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: InkWell(
                                    onTap: () {
                                      _showDialogNoScore(
                                          context,
                                          "Who has too many goals?",
                                          "Decrement Goal",
                                          state.team1Players,
                                          1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.7),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: InkWell(
                                    onTap: () {
                                      _showDialogScore(
                                          context,
                                          "Who scored the goal?",
                                          "Increment Goal",
                                          state.team1Players,
                                          1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.7),
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Green Card",
                                              "Green Card",
                                              state.team1Players,
                                              1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Yellow Card",
                                              "Yellow Card",
                                              state.team1Players,
                                              2);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Red Card",
                                              "Red Card",
                                              state.team1Players,
                                              3);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Red EJECTION Card",
                                              "Red EJECTION Card",
                                              state.team1Players,
                                              4);
                                        },
                                        child: ClipRRect(
                                          child: Banner(
                                            message: 'Ejection',
                                            location: BannerLocation.topEnd,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 6,
                              child: Container(
                                child: _cardDisplay(
                                    context, state.team1, state.cards),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2, child: Container()), //spacing on the right side
                  Expanded(
                    //Second column of three
                    flex: 40,
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 14,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        breakAlert(
                                            context,
                                            state.timer,
                                            state.breakLength,
                                            state.period,
                                            state.breakActive,
                                            state.periodLength,
                                            (state.score1 == state.score2)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        state.score1.toString() +
                                            "-" +
                                            state.score2.toString(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<ScoreboardTOCubit>(context)
                                  .startTimer();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text("Start"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<ScoreboardTOCubit>(context)
                                  .pauseTimer();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text("Time out"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 10,
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    shotClockAlert(context, state.shotclock),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (state.shotclockShouldRun) {
                                                BlocProvider.of<
                                                            ScoreboardTOCubit>(
                                                        context)
                                                    .pauseShotclock();
                                              } else {
                                                BlocProvider.of<
                                                            ScoreboardTOCubit>(
                                                        context)
                                                    .startShotclock();
                                              }
                                            },
                                            child: Center(
                                              child: Text(startOrStop(
                                                  state.shotclockShouldRun)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<ScoreboardTOCubit>(
                                                    context)
                                                .resetShotclock();
                                            BlocProvider.of<ScoreboardTOCubit>(
                                                    context)
                                                .startShotclock();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Center(
                                              child: Text("Reset"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5, left: 5),
                                child: Text(
                                  periodIndicator(
                                      state.period, state.breakActive),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    //third column of three
                    flex: 50,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  state.team2.country.flag)),
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 5,
                                            right: 5),
                                        child: Text(
                                          state.team2.name,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: InkWell(
                                    onTap: () {
                                      _showDialogNoScore(
                                          context,
                                          "Who has too many goals?",
                                          "Decrement Goal",
                                          state.team2Players,
                                          2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.7),
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: InkWell(
                                    onTap: () {
                                      _showDialogScore(
                                          context,
                                          "Who scored the goal?",
                                          "Increment Goal",
                                          state.team2Players,
                                          2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.7),
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Green Card",
                                              "Green Card",
                                              state.team2Players,
                                              1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Yellow Card",
                                              "Yellow Card",
                                              state.team2Players,
                                              2);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Red Card",
                                              "Red Card",
                                              state.team2Players,
                                              3);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                          right: 2,
                                          left: 2),
                                      child: InkWell(
                                        onTap: () {
                                          _showDialogCard(
                                              context,
                                              "Red EJECTION Card",
                                              "Red EJECTION Card",
                                              state.team2Players,
                                              4);
                                        },
                                        child: ClipRRect(
                                          child: Banner(
                                            message: 'Ejection',
                                            location: BannerLocation.topEnd,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: _cardDisplay(
                                  context, state.team2, state.cards),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _updateBtn(context, IconData icon, int widthFlex) {
    return Expanded(
      flex: widthFlex,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  Widget _updateBtnText(context, String text, int widthFlex) {
    return Expanded(
      flex: widthFlex,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  Widget _cardDisplay(BuildContext context, Team team, List<CardPlayer> cards) {
    List<CardPlayer> specific = [];
    for (var card in cards) {
      if (card.player.player.team.id == team.id) {
        specific.add(card);
      }
    }
    return GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 2 / 3,
        children: List.generate(specific.length, (index) {
          switch (specific[index].card) {
            case 1:
              return _cardContainer(context, specific[index], Colors.green,
                  specific[index].timeLeft, index);
              break;
            case 2:
              return _cardContainer(context, specific[index], Colors.yellow,
                  specific[index].timeLeft, index);
              break;
            case 3:
              return _cardContainer(context, specific[index], Colors.red,
                  specific[index].timeLeft, index);
            case 4:
              return _cardContainerEjection(context, specific[index],
                  Colors.red, specific[index].timeLeft, index);
            default:
              return Center();
          }
        }));
  }

  Widget _cardContainer(BuildContext context, CardPlayer player,
      MaterialColor colour, int timeLeft, int indexe) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 2, left: 2),
        child: InkWell(
          onTap: () {
            _showDialogCardEnd(
                context,
                'Remove card?',
                'Do you want to remove the card of player ' +
                    player.player.player.number.toString() +
                    ", " +
                    player.player.player.firstName +
                    " " +
                    player.player.player.lastName +
                    " of team " +
                    player.player.player.team.name +
                    "?",
                player);
          },
          child: Container(
            decoration: BoxDecoration(
                color: colour, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Expanded(
                  flex: 25,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        child: Text(
                          player.player.player.number.toString(),
                        ),
                      )),
                ),
                Expanded(
                  flex: 25,
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        child: Text(
                          _printDuration(Duration(seconds: timeLeft)),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardContainerEjection(BuildContext context, CardPlayer player,
      MaterialColor colour, int timeLeft, int indexe) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 8.0, top: 8.0, right: 2, left: 2),
        child: InkWell(
          onTap: () {
            _showDialogCardEnd(
                context,
                'Remove card?',
                'Do you want to remove the card of player ' +
                    player.player.player.number.toString() +
                    ", " +
                    player.player.player.firstName +
                    " " +
                    player.player.player.lastName +
                    " of team " +
                    player.player.player.team.name +
                    "?",
                player);
          },
          child: ClipRect(
            child: Banner(
              location: BannerLocation.topEnd,
              message: 'Ejection',
              child: Container(
                decoration: BoxDecoration(
                    color: colour, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 25,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 5, right: 5),
                            child: Text(
                              player.player.player.number.toString(),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String periodIndicator(int period, bool breakActive) {
    String output = "Extension " + (period - 2).toString();
    switch (period) {
      case 1:
        output = "Period 1/2";
        break;
      case 2:
        output = "Period 2/2";
        break;
    }
    if (breakActive) {
      output = "Break";
    }
    return output;
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String startOrStop(bool shouldRun) {
    if (shouldRun) {
      return "Stop";
    }
    return "Start";
  }

  void handleClick(String value, BuildContext context) {
    switch (value) {
      case 'Reset timer':
        BlocProvider.of<ScoreboardTOCubit>(context).resetShotclock();
        BlocProvider.of<ScoreboardTOCubit>(context).pauseShotclock();
        BlocProvider.of<ScoreboardTOCubit>(context).resetTimer();
        BlocProvider.of<ScoreboardTOCubit>(context).pauseTimer();
        break;
      case 'Reset game':
        BlocProvider.of<ScoreboardTOCubit>(context).resetGame();
        break;
      case 'Switch sides':
        BlocProvider.of<ScoreboardTOCubit>(context).switchSides();
        break;
      case 'Back to settings':
        Navigator.pop(context);
        break;
    }
  }

  String shotClockAlert(BuildContext context, int shotClock) {
    if (shotClock == 0) {
      Future.delayed(
          Duration.zero,
          () => _showDialogGeneral(
              context, "Shotclock", "The shotclock timer reached zero."));
    }
    return shotClock.toString();
  }

  String breakAlert(BuildContext context, int timer, int breakLength,
      int period, bool breakActive, int periodLength, bool draw) {
    if (timer == breakLength * 60 &&
        period == 1 &&
        breakActive == true &&
        _dialogShowing == false) {
      Future.delayed(Duration.zero,
          () => _showDialogGeneral(context, "Break", "The break is starting."));
    }
    if (timer == 0 &&
        period == 1 &&
        breakActive == true &&
        _dialogShowing == false) {
      Future.delayed(Duration.zero,
          () => _showDialogGeneral(context, "Break", "The break is ending."));
    }
    if (timer == 0 &&
        period >= 2 &&
        draw == false &&
        breakActive == false &&
        _dialogShowing == false) {
      Future.delayed(
          Duration.zero,
          () => _showDialogGeneral(
              context, "End of the game", "The game time has ended."));
    }
    if (timer == 0 &&
        period >= 2 &&
        draw == true &&
        breakActive == false &&
        _dialogShowing == false) {
      Future.delayed(
          Duration.zero,
          () => _showDialogEnd(
              context, "End of the game", "The game time has ended."));
    }
    return _printDuration(Duration(seconds: timer));
  }

  bool _dialogShowing = false;
  void _showDialogGeneral(BuildContext contextI, String title, String text) {
    _dialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  //Ugly hack (should be fixed)
                  if (title == "End of the game") {
                    BlocProvider.of<ScoreboardTOCubit>(contextI).pushServer();
                    Navigator.pop(contextI);
                    Navigator.pop(context);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _dialogShowing = false);
  }

  void _showDialogCardEnd(
      BuildContext contextI, String title, String text, CardPlayer player) {
    _dialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI)
                      .removeCard(player);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Remove card',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _dialogShowing = false);
  }

  void _showDialogEnd(BuildContext contextI, String title, String text) {
    _dialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI).pushServer();
                  Navigator.pop(contextI);
                  Navigator.pop(context);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'End game',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI).extensions(300);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Extensions',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _dialogShowing = false);
  }

  bool _infoDialogShowing = false;
  void _showDialogScore(BuildContext contextI, String title, String text,
      List<PlayerGame> players, int team) {
    _infoDialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Container(
              width: MediaQuery.of(contextI).size.width * 0.7,
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(players.length, (index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<ScoreboardTOCubit>(contextI)
                          .incrementScore(team);
                      BlocProvider.of<ScoreboardTOCubit>(contextI)
                          .goalPlayer(players[index]);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text('Player ' +
                                      players[index].player.number.toString())),
                            ),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 10, left: 10),
                                    child: Text(
                                      players[index].player.firstName +
                                          " " +
                                          players[index].player.lastName,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  );
                }),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI)
                      .incrementScore(team);
                  BlocProvider.of<ScoreboardTOCubit>(contextI).logEvent(
                      1,
                      "Unknown player scored a goal",
                      Player('', players[0].player.team, -1, '', '', false));
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Player not in list',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _infoDialogShowing = false);
  }

  void _showDialogNoScore(BuildContext contextI, String title, String text,
      List<PlayerGame> playersI, int team) {
    List<PlayerGame> players = [];
    for (var player in playersI) {
      if (player.goals != 0) {
        players.add(player);
      }
    }
    _infoDialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Container(
              width: MediaQuery.of(contextI).size.width * 0.7,
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(players.length, (index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<ScoreboardTOCubit>(contextI)
                          .decrementScore(team);
                      BlocProvider.of<ScoreboardTOCubit>(contextI)
                          .noGoalPlayer(players[index]);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text('Player ' +
                                      players[index].player.number.toString())),
                            ),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 10, left: 10),
                                    child: Text(
                                      players[index].player.firstName +
                                          " " +
                                          players[index].player.lastName,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                  child: Text('Goals: ' +
                                      players[index].goals.toString())),
                            ),
                          ],
                        )),
                      ),
                    ),
                  );
                }),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI)
                      .decrementScore(team);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Player not in list',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _infoDialogShowing = false);
  }

  void _showDialogCard(BuildContext contextI, String title, String text,
      List<PlayerGame> players, int card) {
    _infoDialogShowing = true;
    showDialog(
      context: contextI,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Container(
              width: MediaQuery.of(contextI).size.width * 0.7,
              child: GridView.count(
                crossAxisCount: 5,
                children: List.generate(players.length, (index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<ScoreboardTOCubit>(contextI)
                          .cardPlayer(players[index], card);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text('Player ' +
                                      players[index].player.number.toString())),
                            ),
                            Expanded(
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 10, left: 10),
                                    child: Text(
                                      players[index].player.firstName +
                                          " " +
                                          players[index].player.lastName,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  );
                }),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<ScoreboardTOCubit>(contextI)
                      .addCardNoPlayer(players[0], card);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Player not in list',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _infoDialogShowing = false);
  }
}
