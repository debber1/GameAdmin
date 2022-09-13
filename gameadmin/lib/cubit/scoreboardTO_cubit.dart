import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gameadmin/com/localRepository.dart';
import 'package:gameadmin/com/localStorage.dart';
import 'package:gameadmin/com/repositoryTO.dart';
import 'package:gameadmin/models/card.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/player.dart';
import 'package:gameadmin/models/player_game.dart';
import 'package:gameadmin/models/return_data.dart';
import 'package:gameadmin/util/func.dart';
import 'package:gameadmin/models/country.dart';
import 'package:gameadmin/models/division.dart';
import 'package:gameadmin/models/team.dart';

import '../models/pitch.dart';

part 'scoreboardTO_state.dart';

class ScoreboardTOCubit extends Cubit<ScoreboardTOState> {
  final Game game;
  final RepositoryTO repositoryTo;

  ScoreboardTOCubit(this.game, this.repositoryTo)
      : super(ScoreboardTOInitial());
  void setstate() {
    recall(game.id).then((saveState) {
      if (saveState.gameData.id == '') {
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
            team2Players: state.team2Players,
            cards: state.cards,
            gameData: game));
        fetchPlayers();
      } else {
        emit(saveState);
      }
    });
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
            pauseTimer();
            return;
          }
          if (!state.breakActive) {
            timeCards();
          }
          //Backup every 10 sec in case of a crash.
          if (state.timer % 10 == 0) {
            backup(state);
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
              team2Players: state.team2Players,
              cards: state.cards,
              gameData: state.gameData));
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
                team2Players: state.team2Players,
                cards: state.cards,
                gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
        team2Players: state.team1Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
    }
  }

  void resetGame() {
    //Removing all the cards and goals
    for (var player in state.team1Players) {
      player.green = 0;
      player.red = 0;
      player.yellow = 0;
      player.goals = 0;
    }
    for (var player in state.team2Players) {
      player.green = 0;
      player.red = 0;
      player.yellow = 0;
      player.goals = 0;
    }
    state.cards = [];

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
          team2Players: state.team1Players,
          cards: state.cards,
          gameData: state.gameData));
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
          team2Players: state.team2Players,
          cards: state.cards,
          gameData: state.gameData));
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
        team1Players: state.team2Players,
        team2Players: state.team1Players,
        cards: state.cards,
        gameData: state.gameData));
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
        team2Players: state.team1Players,
        cards: state.cards,
        gameData: state.gameData));
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
          team2Players: players[1],
          cards: state.cards,
          gameData: state.gameData));
      backup(state);
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

  void goalPlayer(PlayerGame player) {
    for (var playerlist in state.team1Players) {
      if (playerlist == player) {
        playerlist.goals++;
      }
    }
    for (var playerlist in state.team2Players) {
      if (playerlist == player) {
        playerlist.goals++;
      }
    }
  }

  void noGoalPlayer(PlayerGame player) {
    for (var playerlist in state.team1Players) {
      if (playerlist == player) {
        playerlist.goals--;
      }
    }
    for (var playerlist in state.team2Players) {
      if (playerlist == player) {
        playerlist.goals--;
      }
    }
  }

  void cardPlayer(PlayerGame player, int card) {
    for (var playerlist in state.team1Players) {
      if (playerlist == player) {
        switch (card) {
          case 1:
            playerlist.green++;
            break;
          case 2:
            playerlist.yellow++;
            break;
          case 3:
            playerlist.red++;
            break;
          case 4:
            playerlist.redEjection++;
            break;
          default:
        }
      }
    }
    for (var playerlist in state.team2Players) {
      if (playerlist == player) {
        switch (card) {
          case 1:
            playerlist.green++;
            break;
          case 2:
            playerlist.yellow++;
            break;
          case 3:
            playerlist.red++;
            break;
          case 4:
            playerlist.redEjection++;
            break;
          default:
        }
      }
    }
    addCard(player, card);
  }

  void addCardNoPlayer(PlayerGame player, int card) {
    PlayerGame temp = PlayerGame(
        "",
        Player("", player.player.team, -1, getRandomString(1),
            getRandomString(1), false),
        0,
        0,
        0,
        0,
        0);
    addCard(temp, card);
  }

  void addCard(PlayerGame player, int card) {
    if (card == 4) {
      state.cards.add(new CardPlayer(player, 9999, card));
    } else {
      state.cards.add(new CardPlayer(player, 120, card));
    }
    emit((ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData)));
  }

  void timeCards() {
    for (var card in state.cards) {
      if (card.timeLeft == 0) {
        endCard(card);
      } else {
        card.timeLeft--;
      }
    }
  }

  void removeCard(CardPlayer player) {
    state.cards.remove(player);
    emit((ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData)));
    fixPlayerCard(player);
  }

  void endCard(CardPlayer player) {
    state.cards.remove(player);
    emit((ScoreboardTOState(
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
        team1Players: state.team1Players,
        team2Players: state.team2Players,
        cards: state.cards,
        gameData: state.gameData)));
  }

  void fixPlayerCard(CardPlayer player) {
    if (player.player.player.number != -1) {
      for (var playerlist in state.team1Players) {
        if (playerlist.id == player.player.id) {
          switch (player.card) {
            case 1:
              playerlist.green--;
              break;
            case 2:
              playerlist.yellow--;
              break;
            case 3:
              playerlist.red--;
              break;
            case 4:
              playerlist.redEjection--;
              break;
            default:
          }
        }
      }
      for (var playerlist in state.team2Players) {
        if (playerlist.id == player.player.id) {
          switch (player.card) {
            case 1:
              playerlist.green--;
              break;
            case 2:
              playerlist.yellow--;
              break;
            case 3:
              playerlist.red--;
              break;
            case 4:
              playerlist.redEjection--;
              break;
            default:
          }
        }
      }
    }
  }

  void pushServer() {
    repositoryTo
        .pushResult(ReturnData(game, state.team1Players, state.team2Players));
  }
}
