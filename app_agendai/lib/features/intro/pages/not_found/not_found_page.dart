import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/widgets/alert/alert_area_cubit.dart';
import 'package:app_agendai/core/widgets/app_text_button.dart';
import 'package:app_agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';

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
                onPressed: () {
                  setState(() {
                    getIt<AlertAreaCubit>().showAlert(
                      Alert.success(title: 'Este é um alerta legal! $count'),
                    );
                    getIt<AlertAreaCubit>().showAlert(
                      Alert.error(title: 'Este é um alerta legal! $count'),
                    );
                    count++;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
