import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/app_elevated_button.dart';
import 'package:app_agendai/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int page = 0;

  final pages = [
    OnboardingPageInfo(
      title: 'Acesso a localização',
      description: 'Para facilitar a busca de profissionais em sua região.',
      imagePath: 'assets/onboarding/onboarding_0.svg',
    ),
    OnboardingPageInfo(
      title: 'Ative as notificações',
      description:
          'Para receber avisos importantes sobre os seus agendamentos.',
      imagePath: 'assets/onboarding/onboarding_1.svg',
    ),
    OnboardingPageInfo(
      title: 'Agende uma consulta',
      description:
          'Você poderá encontrar profissionais em sua região e agendar uma consulta com poucos cliques.',
      imagePath: 'assets/onboarding/onboarding_2.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final p in pages)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          p.imagePath,
                        ),
                        const SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            p.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: t.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          p.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              onPageChanged: (p) {
                setState(() {
                  page = p;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 44),
            child: Row(
              children: [
                if (page > 0) ...[
                  AppTextButton(
                    label: 'Voltar',
                    onPressed: () {
                      pageController.animateToPage(
                        page - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: AppElevatedButton(
                    label: 'Próximo',
                    iconPath: 'assets/icons/arrow_right.svg',
                    onPressed: () {
                      pageController.animateToPage(
                        page + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingPageInfo {
  OnboardingPageInfo({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;
}
