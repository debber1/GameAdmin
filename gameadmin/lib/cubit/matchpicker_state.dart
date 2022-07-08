part of 'matchpicker_cubit.dart';

class MatchPickerState {
  int pitchNumber;
  Pitch pitch;
  List<Game> games;

  MatchPickerState(
      {required this.pitchNumber, required this.pitch, required this.games});
}

class MatchPickerInitial extends MatchPickerState {
  MatchPickerInitial()
      : super(pitchNumber: 1, pitch: Pitch('', '', true, true, ''), games: []);
}
