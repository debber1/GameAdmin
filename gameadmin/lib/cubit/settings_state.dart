part of 'settings_cubit.dart';

class SettingsState {
  List<Pitch> pitches;

  SettingsState({required this.pitches});
}

class SettingsInitial extends SettingsState {
  SettingsInitial() : super(pitches: []);
}
