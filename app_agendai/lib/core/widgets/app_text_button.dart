import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return t.lightGray;
          }
          return t.black;
        }),
        minimumSize: MaterialStateProperty.all(const Size(64, 64)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        overlayColor: MaterialStateProperty.all(t.lightGray),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
