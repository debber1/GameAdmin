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
          preferredSize: Size.fromHeight(30.0),
          child: AppBar(
            title: Text('Score Board'),
          ),
        ),
        body: BlocBuilder<ScoreboardCubit, ScoreboardState>(
          builder: (context, state) {
            //Logic for main timer hitting 0
            if (state.timer == 0 && !state.breakActive) {
              BlocProvider.of<ScoreboardCubit>(context).startBreak();
            }
            if (state.timer == 0 && state.breakActive) {
              BlocProvider.of<ScoreboardCubit>(context).restartPeriod();
            }
            if (state.timer == 0 && state.period == 2) {
              //TODO: Implement what needs to happen at the end of a match.
            }

            //Logic for shotclock timer hitting 0
            if (state.shotclock == 0) {
              BlocProvider.of<ScoreboardCubit>(context).pauseShotclock();
              BlocProvider.of<ScoreboardCubit>(context).resetShotclock();
            }

            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //The left column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    BlocProvider.of<ScoreboardCubit>(context)
                                        .incrementScore(1);
                                  },
                                  child: _updateBtn(context, Icons.add, 8, 8)),
                              InkWell(
                                  onTap: () {
                                    BlocProvider.of<ScoreboardCubit>(context)
                                        .decrementScore(1);
                                  },
                                  child:
                                      _updateBtn(context, Icons.remove, 8, 8))
                            ],
                          ),
                          Text(
                            state.score1.toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 4),
                          ),
                        ],
                      ),
                      Text(
                        "Period: " + state.period.toString() + "/2",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 15),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                  Column(
                    //The center column
                    children: [
                      Row(
                        children: [
                          Text(
                            _printDuration(Duration(seconds: state.timer)),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 4),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .startTimer();
                              },
                              child: _updateBtnText(context, "Start", 5, 8.6)),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .pauseTimer();
                              },
                              child: _updateBtnText(context, "Stop", 5, 8.6))
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            BlocProvider.of<ScoreboardCubit>(context)
                                .resetTimer();
                          },
                          child: _updateBtnText(context, "Reset", 2.45, 8.6)),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeTimer(-60);
                              },
                              child:
                                  _updateBtnText(context, "-1 minute", 5, 8.6)),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeTimer(60);
                              },
                              child:
                                  _updateBtnText(context, "+1 minute", 5, 8.6))
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeTimer(-1);
                              },
                              child:
                                  _updateBtnText(context, "-1 second", 5, 8.6)),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeTimer(1);
                              },
                              child:
                                  _updateBtnText(context, "+1 second", 5, 8.6))
                        ],
                      ),
                    ],
                  ),
                  Column(
                    //The right column
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.score2.toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 4),
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    BlocProvider.of<ScoreboardCubit>(context)
                                        .incrementScore(2);
                                  },
                                  child: _updateBtn(context, Icons.add, 8, 8)),
                              InkWell(
                                  onTap: () {
                                    BlocProvider.of<ScoreboardCubit>(context)
                                        .decrementScore(2);
                                  },
                                  child:
                                      _updateBtn(context, Icons.remove, 8, 8))
                            ],
                          ),
                        ],
                      ),
                      Text(
                        state.shotclock.toString(),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 5.5),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .startShotclock();
                              },
                              child: _updateBtnText(context, "Start", 8, 12)),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .pauseShotclock();
                              },
                              child: _updateBtnText(context, "Stop", 8, 12))
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            BlocProvider.of<ScoreboardCubit>(context)
                                .resetShotclock();
                          },
                          child: _updateBtnText(context, "Reset", 3.85, 12)),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeShotclock(-1);
                              },
                              child: _updateBtnText(context, "-1", 8, 12)),
                          InkWell(
                              onTap: () {
                                BlocProvider.of<ScoreboardCubit>(context)
                                    .changeShotclock(1);
                              },
                              child: _updateBtnText(context, "+1", 8, 12))
                        ],
                      ),
                    ],
                  ),
                ]);
          },
        ),
      ),
    );
  }

  Widget _updateBtn(context, IconData icon, double widthDiv, double heightDiv) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width / widthDiv,
        height: MediaQuery.of(context).size.height / heightDiv,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  Widget _updateBtnText(
      context, String text, double widthDiv, double heightDiv) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width / widthDiv,
        height: MediaQuery.of(context).size.height / heightDiv,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
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
}
