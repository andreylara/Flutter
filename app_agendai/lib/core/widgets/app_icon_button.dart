import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends AppStateless {
  const AppIconButton({
    super.key,
    required this.id,
    required this.iconPath,
    required this.onPressed,
  });

  final String id;
  final String iconPath;
  final VoidCallback? onPressed;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed != null
              ? () {
                  onPressed!.call();
                  analytics.logButtonPressed(id);
                }
              : null,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
