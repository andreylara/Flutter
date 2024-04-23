import 'package:agendai/core/flavor/flavor_config.dart';
import 'package:agendai/route/app_routes.dart';
import 'package:flutter/material.dart';

void bootstrap(FlavorConfig config) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
