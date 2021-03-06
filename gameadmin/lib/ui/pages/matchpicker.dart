// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/matchpicker_cubit.dart';
import 'package:gameadmin/util/constants.dart';

class MatchPicker extends StatelessWidget {
  MatchPicker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MatchPickerCubit>(context).fetchPitch();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          title: Text('GameAdmin - github.com/debber1/GameAdmin'),
        ),
      ),
      body: BlocBuilder<MatchPickerCubit, MatchPickerState>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    flex: 50,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.games.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, tournamentOrganiserRoute,
                                arguments: state.games[index]),
                            child: Container(
                              height: 100,
                              color: Colors.grey.shade300,
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container()),
                                                Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                state
                                                                    .games[
                                                                        index]
                                                                    .team1
                                                                    .country
                                                                    .flag),
                                                          ),
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                Expanded(
                                                  flex: 20,
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        state.games[index].team1
                                                            .name,
                                                      )),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container()),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        state.games[index]
                                                            .division.shortName,
                                                      )),
                                                ),
                                                Expanded(
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        "#" +
                                                            state.games[index]
                                                                .gameNumber
                                                                .toString(),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  state.games[index].time.hour
                                                          .toString() +
                                                      ":" +
                                                      state.games[index].time
                                                          .minute
                                                          .toString(),
                                                )),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                state
                                                                    .games[
                                                                        index]
                                                                    .teamRef
                                                                    .country
                                                                    .flag),
                                                          ),
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                Expanded(
                                                  flex: 20,
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        state.games[index]
                                                            .teamRef.name,
                                                      )),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            top: 8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: NetworkImage(
                                                                state
                                                                    .games[
                                                                        index]
                                                                    .team2
                                                                    .country
                                                                    .flag),
                                                          ),
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                Expanded(
                                                  flex: 20,
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        state.games[index].team2
                                                            .name,
                                                      )),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container()),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child:
                                                                Text("Draw")),
                                                      ),
                                                      Expanded(
                                                          child: Icon(yayOrNay(
                                                              state.games[index]
                                                                  .drawAllowed)))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                                "Forfait")),
                                                      ),
                                                      Expanded(
                                                          child: Icon(yayOrNay(
                                                              !state
                                                                  .games[index]
                                                                  .forfait)))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData yayOrNay(bool status) {
    if (status) {
      return Icons.check_box;
    }
    return Icons.warning;
  }
}
