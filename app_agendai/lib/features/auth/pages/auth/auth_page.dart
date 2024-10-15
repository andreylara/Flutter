import 'package:app_agendai/core/route/app_routes.dart';
import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/app_divider.dart';
import 'package:app_agendai/core/widgets/app_elevated_button.dart';
import 'package:app_agendai/core/widgets/app_outlined_button.dart';
import 'package:app_agendai/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();

    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/brand/logo.svg'),
                  const SizedBox(width: 16),
                  SvgPicture.asset('assets/brand/title.svg'),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Olá! Como deseja acessar?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: t.black,
                ),
              ),
              const SizedBox(height: 50),
              AppElevatedButton(
                id: 'entrar',
                label: 'Entrar',
                onPressed: () => context.push(AppRoutes.login.fullPath),
              ),
              const SizedBox(height: 24),
              AppOutlinedButton(
                id: 'cadastrar',
                label: 'Cadastrar',
                onPressed: () => context.push(AppRoutes.signUp.fullPath),
              ),
              const SizedBox(height: 24),
              const AppDivider(text: 'ou'),
              const SizedBox(height: 8),
              AppTextButton(
                label: 'Entrar como visitante',
                color: t.primary,
                onPressed: () => context.push(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
