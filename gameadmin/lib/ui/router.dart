import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameadmin/ui/pages/scoreboard.dart';

class GameAdminRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => ScoreBoard());
      default:
        return null;
    }
  }
}
