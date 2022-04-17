import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scoreboard_state.dart';

class ScoreboardCubit extends Cubit<ScoreboardState> {
  ScoreboardCubit() : super(ScoreboardInitial());
  void incrementScore(int team) {
    if (team == 1 && state.score1 != 99) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1 + 1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    } else if (team == 2 && state.score2 != 99) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2 + 1,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    }
  }

  void decrementScore(int team) {
    if (team == 1 && state.score1 != 0) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1 - 1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    } else if (team == 2 && state.score2 != 0) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2 - 1,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    }
  }

  void mainTimer() {
    if (!state.timerRunning) {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.timerShouldRun) {
          emit(ScoreboardState(
              timer: state.timer - 1,
              shotclock: state.shotclock,
              breakLength: state.breakLength,
              periodLength: state.periodLength,
              score1: state.score1,
              score2: state.score2,
              period: state.period,
              timerRunning: true,
              timerShouldRun: state.timerShouldRun,
              breakActive: state.breakActive,
              shotclockShouldRun: state.shotclockShouldRun));
        }
      });
    }
  }

  void shotclockTimer() {
    if (!state.timerRunning) {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.shotclockShouldRun) {
          emit(ScoreboardState(
              timer: state.timer,
              shotclock: state.shotclock - 1,
              breakLength: state.breakLength,
              periodLength: state.periodLength,
              score1: state.score1,
              score2: state.score2,
              period: state.period,
              timerRunning: state.timerRunning,
              timerShouldRun: state.timerShouldRun,
              breakActive: state.breakActive,
              shotclockShouldRun: state.shotclockShouldRun));
        }
      });
    }
  }

  void startTimer() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: true,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun));
  }

  void pauseTimer() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: false,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun));
  }

  void resetTimer() {
    //TODO: When break is active, reset to breaklength, else reset to periodlength
    if (state.breakActive) {
      emit(ScoreboardState(
          timer: state.breakLength * 60,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    } else {
      emit(ScoreboardState(
          timer: state.periodLength * 60,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    }
  }

  void changeTimer(int amount) {
    if (state.timer >= -amount) {
      emit(ScoreboardState(
          timer: state.timer + amount,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    }
  }

  void startBreak() {
    emit(ScoreboardState(
        timer: state.breakLength * 60,
        shotclock: 60,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score2,
        score2: state.score1,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: true,
        shotclockShouldRun: false));
  }

  void restartPeriod() {
    emit(ScoreboardState(
        timer: state.periodLength * 60,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: 2,
        timerRunning: state.timerRunning,
        timerShouldRun: false,
        breakActive: false,
        shotclockShouldRun: state.shotclockShouldRun));
  }

  void startShotclock() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: true));
  }

  void pauseShotclock() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: false));
  }

  void resetShotclock() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: 60,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun));
  }

  void changeShotclock(int amount) {
    if (state.shotclock >= -amount && state.shotclock + amount <= 60) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: state.shotclock + amount,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun));
    }
  }
}
