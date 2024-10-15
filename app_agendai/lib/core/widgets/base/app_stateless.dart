import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/firebase/analytics/app_analytics.dart';
import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppStateless extends StatelessWidget {
  const AppStateless({super.key});

  Widget builder(BuildContext context, AppTheme theme);

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return builder(context, t);
  }

  AppAnalytics get analytics => getIt<AppAnalytics>();
}
