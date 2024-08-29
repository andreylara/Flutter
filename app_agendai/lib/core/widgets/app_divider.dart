import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: t.gray,
            thickness: 1,
          ),
        ),
        if (text != null)
          Expanded(
            child: Center(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 15,
                  color: t.black,
                ),
              ),
            ),
          ),
        Expanded(
          child: Divider(
            color: t.gray,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
