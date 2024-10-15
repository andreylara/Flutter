import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/alert/alert_area_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertWidget extends StatefulWidget {
  const AlertWidget({super.key, required this.alert});

  final Alert alert;

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.alert.duration)
            .then((value) => _controller.reverse());
      } else if (status == AnimationStatus.dismissed) {
        getIt<AlertAreaCubit>().removeAlert(widget.alert);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: switch (widget.alert.type) {
                  AlertType.error => t.error,
                  AlertType.success => t.success,
                  AlertType.notification => Colors.white,
                },
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(6, 14),
                    blurRadius: 15,
                    spreadRadius: 0,
                    color: t.black.withOpacity(0.08),
                  )
                ]),
            padding: const EdgeInsets.all(24),
            child: InkWell(
              onTap: () {
                widget.alert.onPressed?.call();
                getIt<AlertAreaCubit>().removeAlert(widget.alert);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.alert.title,
                          style: t.body16Bold,
                        ),
                        if (widget.alert.subtitle != null)
                          Text(
                            widget.alert.subtitle!,
                            style: t.body13,
                          )
                      ],
                    ),
                  ),
                  Icon(
                    switch (widget.alert.type) {
                      AlertType.error => Icons.cancel_outlined,
                      AlertType.success => Icons.check_circle_outline_outlined,
                      AlertType.notification => Icons.notifications,
                    },
                    color: switch (widget.alert.type) {
                      AlertType.error => t.red,
                      AlertType.success => t.secondary,
                      AlertType.notification => t.black,
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
