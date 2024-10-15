import 'package:app_agendai/core/route/app_routes.dart';
import 'package:app_agendai/core/widgets/app_text_button.dart';
import 'package:app_agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  NotFoundPageState createState() => NotFoundPageState();
}

class NotFoundPageState extends State<NotFoundPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              imagePath: 'assets/intro/not-found.svg',
              title: 'Página não encontrada :(',
              body: '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppTextButton(
                label: 'Voltar',
                onPressed: () => context.go(AppRoutes.home),
              ),
            ),
          )
        ],
      ),
    );
  }
}
