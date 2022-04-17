import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/scoreboard_cubit.dart';
import 'package:gameadmin/ui/pages/scoreboard.dart';

class GameAdminRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => ScoreboardCubit(),
                  child: ScoreBoard(),
                ));
      default:
        return null;
    }
  }
}
