import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class AppEmptyStateIndicator extends AppStateless {
  const AppEmptyStateIndicator(
      {super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      children: [
        Icon(
          icon,
          size: 100,
          color: theme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: theme.body16Bold,
        ),
      ],
    );
  }
}
