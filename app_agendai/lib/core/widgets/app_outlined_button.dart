import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppOutlinedButton extends AppStateless {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconPath,
    this.minHeight,
    required this.id,
  });

  final String id;
  final String label;
  final VoidCallback? onPressed;
  final String? iconPath;
  final double? minHeight;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return OutlinedButton(
      onPressed: onPressed != null
          ? () {
              onPressed!.call();
              analytics.logButtonPressed(id);
            }
          : null,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: theme.lightGray);
          }
          return BorderSide(color: theme.primary);
        }),
        minimumSize: WidgetStateProperty.all(Size(128, minHeight ?? 64)),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return theme.lightGray;
          }
          return theme.primary;
        }),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          if (iconPath != null)
            const SizedBox(
              width: 24,
            ),
          Center(
            child: Text(label),
          ),
          if (iconPath != null)
            SvgPicture.asset(
              iconPath!,
              width: 24,
            )
        ],
      ),
    );
  }
}
