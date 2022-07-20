// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/settings_cubit.dart';
import 'package:gameadmin/models/pitch.dart';
import 'package:gameadmin/util/constants.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingsCubit>(context).fetchPitch();

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
          ),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 50,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, gameAdminRoute),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text("Without Tournament Organiser"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 50,
                    child: InkWell(
                      onTap: () => _showDialogPitch(
                        context,
                        'Pitch',
                        'Pitch',
                        state.pitches,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text("With Tournament Organiser"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _infoDialogShowing = false;
  void _showDialogPitch(
      BuildContext contextI, String title, String text, List<Pitch> pitches) {
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
                children: List.generate(pitches.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, matchPickerRoute,
                          arguments: pitches[index]);
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
                              child: Center(child: Text(pitches[index].name)),
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
            ],
          ),
        );
      },
    ).then((_) => _infoDialogShowing = false);
  }
}
