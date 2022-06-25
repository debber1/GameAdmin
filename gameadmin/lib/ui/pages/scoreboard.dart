// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/scoreboard_cubit.dart';

class ScoreBoard extends StatelessWidget {
  ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScoreboardCubit>(context).shotclockTimer();
    BlocProvider.of<ScoreboardCubit>(context).mainTimer();

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
            title: Text('GameAdmin - github.com/debber1/GameAdmin'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (choice) => handleClick(choice, context),
                itemBuilder: (BuildContext context) {
                  return {'Reset timer', 'Reset game', 'Extensions'}
                      .map((String choice) {
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
        body: BlocBuilder<ScoreboardCubit, ScoreboardState>(
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: state.team1Colour,
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
                                            top: 5, bottom: 5, right: 40),
                                        child: Text(
                                          state.team1,
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
                                      BlocProvider.of<ScoreboardCubit>(context)
                                          .decrementScore(1);
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
                                      BlocProvider.of<ScoreboardCubit>(context)
                                          .incrementScore(1);
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
                          Expanded(flex: 11, child: Container())
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
                                        _printDuration(
                                            Duration(seconds: state.timer)),
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
                              BlocProvider.of<ScoreboardCubit>(context)
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
                              BlocProvider.of<ScoreboardCubit>(context)
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
                                    state.shotclock.toString(),
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
                                                            ScoreboardCubit>(
                                                        context)
                                                    .pauseShotclock();
                                              } else {
                                                BlocProvider.of<
                                                            ScoreboardCubit>(
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
                                            BlocProvider.of<ScoreboardCubit>(
                                                    context)
                                                .resetShotclock();
                                            BlocProvider.of<ScoreboardCubit>(
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: state.team2Colour,
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
                                            top: 5, bottom: 5, right: 40),
                                        child: Text(
                                          state.team2,
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
                                      BlocProvider.of<ScoreboardCubit>(context)
                                          .decrementScore(2);
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
                                      BlocProvider.of<ScoreboardCubit>(context)
                                          .incrementScore(2);
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
                          Expanded(flex: 11, child: Container())
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
        BlocProvider.of<ScoreboardCubit>(context).resetShotclock();
        BlocProvider.of<ScoreboardCubit>(context).pauseShotclock();
        BlocProvider.of<ScoreboardCubit>(context).resetTimer();
        BlocProvider.of<ScoreboardCubit>(context).pauseTimer();
        break;
      case 'Reset game':
        BlocProvider.of<ScoreboardCubit>(context).resetGame();
        break;
      case 'Extensions':
        break;
    }
  }
}
