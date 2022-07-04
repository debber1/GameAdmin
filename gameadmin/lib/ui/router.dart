import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameadmin/cubit/scoreboard_cubit.dart';
import 'package:gameadmin/ui/pages/scoreboard.dart';
import 'package:gameadmin/ui/pages/settings.dart';

class GameAdminRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Settings());
      default:
        return null;
    }
  }
}
