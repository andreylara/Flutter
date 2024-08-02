import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconPath,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return t.gray;
          }
          return t.primary;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(128, 64)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return t.lightGray;
          }
          return Colors.white;
        }),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          if (iconPath != null)
            const SizedBox(
              width: 24,
            ),
          Expanded(
            child: Center(
              child: Text(label),
            ),
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
