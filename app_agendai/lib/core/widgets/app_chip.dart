import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';

class AppChip extends AppStateless {
  const AppChip({super.key, required this.text, this.minWidth, this.textStyle});

  final String text;
  final double? minWidth;
  final TextStyle? textStyle;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Container(
      constraints:
          minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: theme.lightGray,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle ?? theme.label11Bold.copyWith(color: theme.primary),
      ),
    );
  }
}
