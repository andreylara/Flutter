import 'package:app_agendai/core/device/app_external_launcher.dart';
import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/widgets/app_elevated_button.dart';
import 'package:app_agendai/features/intro/widgets/intro_base_page.dart';
import 'package:flutter/material.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: IntroBasePage(
              imagePath: 'assets/intro/force-update.svg',
              title: 'Nova atualização',
              body: 'Atualize o app para receber todas as novidades!',
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
              child: AppElevatedButton(
                label: 'Atualizar',
                onPressed: getIt<AppExternalLauncher>().launchStore,
              ),
            ),
          )
        ],
      ),
    );
  }
}
