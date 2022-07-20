import 'package:flutter/material.dart';
import 'package:gameadmin/ui/router.dart';

void main() {
  runApp(MyApp(
    router: GameAdminRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final GameAdminRouter router;
  const MyApp({Key? key, required this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
    );
  }
}
