import 'package:bloc/bloc.dart';

import '../com/repositoryTO.dart';
import '../models/game.dart';
import '../models/pitch.dart';
part 'matchpicker_state.dart';

class MatchPickerCubit extends Cubit<MatchPickerState> {
  final RepositoryTO repositoryTO;
  final Pitch pitch;

  MatchPickerCubit(this.repositoryTO, this.pitch) : super(MatchPickerInitial());

  void fetchGames(String pitchId) {
    repositoryTO.fetchGames(pitchId).then((games) {
      emit(MatchPickerState(pitch: state.pitch, games: games));
    });
  }

  void fetchPitch() {
    emit(MatchPickerState(pitch: pitch, games: state.games));
    fetchGames(state.pitch.id);
  }
}
