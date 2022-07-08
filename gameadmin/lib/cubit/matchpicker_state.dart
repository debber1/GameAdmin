part of 'matchpicker_cubit.dart';

class MatchPickerState {
  int pitchNumber;

  MatchPickerState({required this.pitchNumber});
}

class MatchPickerInitial extends MatchPickerState {
  MatchPickerInitial() : super(pitchNumber: 1);
}

class MatchPickerPitch extends MatchPickerInitial {
  final Pitch pitch;
  MatchPickerPitch(this.pitch);
}

class MatchPickerGames extends MatchPickerInitial {
  final List<Game> games;
  MatchPickerGames(this.games);
}
