import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gameadmin/com/repositoryTO.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:meta/meta.dart';
import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/team.dart';

part 'scoreboardTO_state.dart';

class ScoreboardTOCubit extends Cubit<ScoreboardTOState> {
  final Game game;
  final RepositoryTO repositoryTo;

  ScoreboardTOCubit(this.game, this.repositoryTo)
      : super(ScoreboardTOInitial());
  void setstate() {
    emit(ScoreboardTOState(
        timer: state.timer,
        shotclock: state.shotclock,
        breakLength: state.breakLength,
        periodLength: state.periodLength,
        score1: game.scoreTeam1,
        score2: game.scoreTeam2,
        period: state.period,
        timerRunning: state.timerRunning,
        timerShouldRun: state.timerShouldRun,
        breakActive: state.breakActive,
        shotclockShouldRun: state.shotclockShouldRun,
        team1: game.team1,
        team2: game.team2,
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void incrementScore(int team) {
    if (team == 1 && state.score1 != 99) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    } else if (team == 2 && state.score2 != 99) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
    fixGoal();
  }

  void decrementScore(int team) {
    if (team == 1 && state.score1 != 0) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    } else if (team == 2 && state.score2 != 0) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
    fixGoal();
  }

  void mainTimer() {
    if (!state.timerRunning) {
      Timer? timer;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state.timerShouldRun) {
          if (state.timer == 0 && !state.breakActive && state.period == 1) {
            startBreak();
            return;
          }
          if (state.timer == 0 && state.breakActive) {
            restartPeriod();
            return;
          }
          if (state.timer == 0 && state.period >= 2) {
            //TODO: Implement what needs to happen at the end of a match.
            pauseTimer();
            return;
          }
          emit(ScoreboardTOState(
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
              team1Players: state.team1Players,
              team2Players: state.team2Players));
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
            emit(ScoreboardTOState(
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
                team1Players: state.team1Players,
                team2Players: state.team2Players));
          }
        }
      });
    }
  }

  void startTimer() {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void pauseTimer() {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void resetTimer() {
    //TODO: When break is active, reset to breaklength, else reset to periodlength
    if (state.breakActive) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    } else {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
  }

  void changeTimer(int amount) {
    if (state.timer >= -amount) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
  }

  void startBreak() {
    emit(ScoreboardTOState(
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
        team1Players: state.team2Players,
        team2Players: state.team1Players));
    fixGoal();
  }

  void restartPeriod() {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
    fixGoal();
  }

  void startShotclock() {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void pauseShotclock() {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void resetShotclock() {
    emit(ScoreboardTOState(
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
        shotclockShouldRun: state.shotclockShouldRun,
        team1: state.team1,
        team2: state.team2,
        team1Players: state.team1Players,
        team2Players: state.team2Players));
  }

  void changeShotclock(int amount) {
    if (state.shotclock >= -amount && state.shotclock + amount <= 60) {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
  }

  void resetGame() {
    if (state.breakActive == true || state.period == 2) {
      emit(ScoreboardTOState(
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
          team1Players: state.team2Players,
          team2Players: state.team1Players));
    } else {
      emit(ScoreboardTOState(
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
          team1Players: state.team1Players,
          team2Players: state.team2Players));
    }
    fixGoal();
  }

  void extensions(int length) {
    emit(ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players));
    fixGoal();
  }

  void switchSides() {
    emit(ScoreboardTOState(
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
        team1Players: state.team2Players,
        team2Players: state.team1Players));
    fixGoal();
  }

  void fetchPlayers() {
    final List<String> ids = [state.team1.id, state.team2.id];
    repositoryTo.fetchPlayers(ids).then((players) {
      emit(ScoreboardTOState(
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
          team1: state.team1,
          team2: state.team2,
          team1Players: players[0],
          team2Players: players[1]));
    });
  }

  void fixGoal() {
    if (state.team1.id == game.team1.id) {
      game.scoreTeam1 = state.score1;
      game.scoreTeam2 = state.score2;
    } else {
      game.scoreTeam1 = state.score2;
      game.scoreTeam2 = state.score1;
    }
  }
}
