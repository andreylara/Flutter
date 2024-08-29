import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/app_elevated_button.dart';
import 'package:app_agendai/features/scheduling/data/scheduling_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextSchedulesSection extends StatelessWidget {
  const HomeNextSchedulesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Próximos agendamentos',
            style: t.body16Bold,
          ),
        ),
        const SizedBox(height: 10),
        AppElevatedButton(
          label: 'Testar',
          onPressed: () async {
            final SchedulingRepository repository = getIt();
            final schedules = await repository.getUserSchedules();
            print(schedules);
          },
        ),
      ],
    );
  }
}
