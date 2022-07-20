import 'package:bloc/bloc.dart';
import 'package:gameadmin/util/server.dart';

import '../com/repositoryTO.dart';
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
