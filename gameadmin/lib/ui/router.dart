import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/com/networkServiceTO.dart';
import 'package:gameadmin/com/repositoryTO.dart';
import 'package:gameadmin/cubit/matchpicker_cubit.dart';
import 'package:gameadmin/cubit/scoreboardTO_cubit.dart';
import 'package:gameadmin/cubit/scoreboard_cubit.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/ui/pages/matchpicker.dart';
import 'package:gameadmin/ui/pages/scoreboard.dart';
import 'package:gameadmin/ui/pages/scoreboardTO.dart';
import 'package:gameadmin/ui/pages/settings.dart';
import 'package:gameadmin/util/constants.dart';

class GameAdminRouter {
  RepositoryTO repositoryTO = RepositoryTO(NetworkServiceTO());

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Settings());
      case gameAdminRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => ScoreboardCubit(),
                  child: ScoreBoard(),
                ));
      case matchPickerRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      MatchPickerCubit(repositoryTO),
                  child: MatchPicker(),
                ));
      case tournamentOrganiserRoute:
        final game = settings.arguments as Game;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => ScoreboardTOCubit(game),
                  child: ScoreBoardTO(),
                ));
      default:
        return null;
    }
  }
}
