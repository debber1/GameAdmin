part of 'matchpicker_cubit.dart';

class MatchPickerState {
  Pitch pitch;
  List<Game> games;

  MatchPickerState({required this.pitch, required this.games});
}

class MatchPickerInitial extends MatchPickerState {
  MatchPickerInitial() : super(pitch: Pitch('', '', true, true, ''), games: []);
}
