import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/com/networkServiceTO.dart';
import 'package:gameadmin/com/repositoryTO.dart';
import 'package:gameadmin/cubit/matchpicker_cubit.dart';
import 'package:gameadmin/cubit/scoreboardTO_cubit.dart';
import 'package:gameadmin/cubit/scoreboard_cubit.dart';
import 'package:gameadmin/cubit/settings_cubit.dart';
import 'package:gameadmin/models/game.dart';
import 'package:gameadmin/models/pitch.dart';
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
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SettingsCubit(repositoryTO),
                  child: Settings(),
                ));
      case gameAdminRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ScoreboardCubit(repositoryTO),
                  child: ScoreBoard(),
                ));
      case matchPickerRoute:
        final pitch = settings.arguments as Pitch;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => MatchPickerCubit(repositoryTO, pitch),
                  child: MatchPicker(),
                ));
      case tournamentOrganiserRoute:
        final game = settings.arguments as Game;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ScoreboardTOCubit(game, repositoryTO),
                  child: ScoreBoardTO(),
                ));
      default:
        return null;
    }
  }
}
