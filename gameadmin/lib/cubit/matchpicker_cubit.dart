import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../com/repositoryTO.dart';
import '../models/game.dart';
import '../models/pitch.dart';
part 'matchpicker_state.dart';

class MatchPickerCubit extends Cubit<MatchPickerState> {
  final RepositoryTO repositoryTO;

  MatchPickerCubit(this.repositoryTO) : super(MatchPickerInitial());

  void fetchPitch() {
    repositoryTO.fetchPitch();
  }
}
