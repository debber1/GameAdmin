import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gameadmin/ui/pages/settings.dart';
import 'package:gameadmin/util/server.dart';
import 'package:meta/meta.dart';

import '../com/repositoryTO.dart';
import '../models/game.dart';
import '../models/pitch.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final RepositoryTO repositoryTO;

  SettingsCubit(this.repositoryTO) : super(SettingsInitial());
  void fetchPitch() {
    repositoryTO.fetchPitch(tournamentID).then((pitches) {
      emit(SettingsState(pitches: pitches));
    });
  }
}
