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
    return MaterialApp(
      title: 'GameAdmin',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: AppBar(
            title: Text('GameAdmin - github.com/debber1/GameAdmin'),
          ),
        ),
        body: BlocBuilder<MatchPickerCubit, MatchPickerState>(
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
                      onTap: () => Navigator.pushNamed(
                          context, tournamentOrganiserRoute),
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
}
