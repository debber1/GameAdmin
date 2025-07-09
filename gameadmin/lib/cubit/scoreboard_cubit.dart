import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gameadmin/com/repositoryTO.dart';
import 'package:gameadmin/models/pitch.dart';

part 'scoreboard_state.dart';

class ScoreboardCubit extends Cubit<ScoreboardState> {
  final RepositoryTO repositoryTO;
  final String temp_ip = "192.168.2.13";

  ScoreboardCubit(this.repositoryTO) : super(ScoreboardInitial());

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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void killTimer() {
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
        shotclockShouldRun: state.shotclockShouldRun,
        cancelTimer: true,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
  }

  void allowTimer() {
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
        shotclockShouldRun: state.shotclockShouldRun,
        cancelTimer: false,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void mainTimer() {
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    if (!state.timerRunning) {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.timerShouldRun) {
          if (state.timer == 0 && !state.breakActive && state.period == 1) {
            repositoryTO.soundHornMain(2, 6,
                Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
            startBreak();
            return;
          }
          if (state.timer == 0 && state.breakActive) {
            restartPeriod();
            return;
          }
          if (state.timer == 0 && state.period >= 2) {
            //TODO: Implement what needs to happen at the end of a match.
            repositoryTO.soundHornMain(3, 6,
                Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
            pauseTimer();
            return;
          }
          if (state.shotclock == 20) {
            repositoryTO.soundShotClockHorn(1, 5,
                Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
          }
          if (state.shotclock == 0) {
            repositoryTO.soundShotClockHorn(2, 5,
                Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
          }
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
              shotclockShouldRun: state.shotclockShouldRun,
              team1: state.team1,
              team2: state.team2,
              team1Colour: state.team1Colour,
              team2Colour: state.team2Colour));
        }
        repositoryTO.syncScoreBoard(
            state.timer,
            state.shotclock,
            state.score1,
            state.score2,
            Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
        if (state.cancelTimer ?? false) {
          timer.cancel();
        }
      });
    }
  }

  void shotclockTimer() {
    if (!state.timerRunning) {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.shotclockShouldRun) {
          if (state.shotclock == 0) {
            pauseShotclock();
            resetShotclock();
          } else {
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
                shotclockShouldRun: state.shotclockShouldRun,
                team1: state.team1,
                team2: state.team2,
                team1Colour: state.team1Colour,
                team2Colour: state.team2Colour));
          }
          // Sync score board if main timer is not running but shot clock is
          if (!state.timerShouldRun) {
            repositoryTO.syncScoreBoard(
                state.timer,
                state.shotclock,
                state.score1,
                state.score2,
                Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
          }
        }
        if (state.cancelTimer ?? false) {
          timer.cancel();
        }
      });
    }
  }

  void startTimer() {
    startShotclock();
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
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
  }

  void pauseTimer() {
    pauseShotclock();
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
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void setTimer(int newTime) {
    if (newTime <= 600) {
      emit(ScoreboardState(
          timer: newTime,
          shotclock: state.shotclock,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void setShotclockTimer(int newTime) {
    if (newTime <= 60) {
      emit(ScoreboardState(
          timer: state.timer,
          shotclock: newTime,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: state.score1,
          score2: state.score2,
          period: state.period,
          timerRunning: state.timerRunning,
          timerShouldRun: state.timerShouldRun,
          breakActive: state.breakActive,
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
        shotclockShouldRun: false,
        team1: state.team2,
        team2: state.team1,
        team1Colour: state.team2Colour,
        team2Colour: state.team1Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
        shotclockShouldRun: true,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
        shotclockShouldRun: false,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
  }

  void resetShotclock() {
    int resetTime = 60;
    if (state.timer <= 60) {
      resetTime = state.timer;
    }
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: resetTime,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score1,
        score2: state.score2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team1,
        team2: state.team2,
        team1Colour: state.team1Colour,
        team2Colour: state.team2Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
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
          shotclockShouldRun: state.shotclockShouldRun,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void resetGame() {
    if (state.breakActive == true || state.period == 2) {
      emit(ScoreboardState(
          timer: state.periodLength * 60,
          shotclock: 60,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: 0,
          score2: 0,
          period: 1,
          timerRunning: state.timerRunning,
          timerShouldRun: false,
          breakActive: false,
          shotclockShouldRun: false,
          team1: state.team2,
          team2: state.team1,
          team1Colour: state.team2Colour,
          team2Colour: state.team1Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    } else {
      emit(ScoreboardState(
          timer: state.periodLength * 60,
          shotclock: 60,
          breakLength: state.breakLength,
          periodLength: state.periodLength,
          score1: 0,
          score2: 0,
          period: 1,
          timerRunning: state.timerRunning,
          timerShouldRun: false,
          breakActive: false,
          shotclockShouldRun: false,
          team1: state.team1,
          team2: state.team2,
          team1Colour: state.team1Colour,
          team2Colour: state.team2Colour));
      repositoryTO.syncScoreBoard(
          state.timer,
          state.shotclock,
          state.score1,
          state.score2,
          Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
    }
  }

  void extensions(int length) {
    emit(ScoreboardState(
        timer: length,
        shotclock: 60,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score2,
        score2: state.score1,
        period: state.period + 1,
        timerRunning: state.timerRunning,
        timerShouldRun: false,
        breakActive: false,
        shotclockShouldRun: false,
        team1: state.team2,
        team2: state.team1,
        team1Colour: state.team2Colour,
        team2Colour: state.team1Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
  }

  void switchSides() {
    emit(ScoreboardState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: state.score2,
        score2: state.score1,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team2,
        team2: state.team1,
        team1Colour: state.team2Colour,
        team2Colour: state.team1Colour));
    repositoryTO.syncScoreBoard(
        state.timer,
        state.shotclock,
        state.score1,
        state.score2,
        Pitch("1", "placeHolder", true, true, "John Doe", temp_ip));
  }
}
