import 'dart:async';

import 'package:bloc/bloc.dart';

import '../com/repositoryTO.dart';
import '../models/game.dart';
import '../models/pitch.dart';
part 'matchpicker_state.dart';

class MatchPickerCubit extends Cubit<MatchPickerState> {
  final RepositoryTO repositoryTO;
  final Pitch pitch;
  Timer? timer;

  MatchPickerCubit(this.repositoryTO, this.pitch) : super(MatchPickerInitial());

  void fetchGames(String pitchId) {
    repositoryTO.fetchGames(pitchId).then((games) {
      emit(MatchPickerState(pitch: state.pitch, games: games));
    });
  }

  void fetchPitch() {
    emit(MatchPickerState(pitch: pitch, games: state.games));
    fetchGames(state.pitch.id);
    try {
      timer =
          Timer.periodic(const Duration(milliseconds: 5000), (Timer t) async {
        fetchGames(state.pitch.id);
      });
    } on Exception {
      emit(MatchPickerState(pitch: pitch, games: state.games));
    }
  }

  void disposeTimer() {
    timer?.cancel();
    //print('timer is disposed');
  }
}
