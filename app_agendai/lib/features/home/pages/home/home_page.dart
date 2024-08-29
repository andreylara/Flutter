import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/features/home/pages/home/sections/home_header_section.dart';
import 'package:app_agendai/features/home/pages/home/sections/home_next_schedules_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderSection(),
          Expanded(
            child: ListView(
              children: const [
                HomeNextSchedulesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
