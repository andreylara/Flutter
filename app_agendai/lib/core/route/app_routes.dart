import 'package:app_agendai/features/auth/pages/auth/auth_page.dart';
import 'package:app_agendai/features/auth/pages/login/login_page.dart';
import 'package:app_agendai/features/auth/pages/sign_up/sign_up_page.dart';
import 'package:app_agendai/features/home/pages/home/home_page.dart';
import 'package:app_agendai/features/intro/pages/force_update/force_update_page.dart';
import 'package:app_agendai/features/intro/pages/maintenance/maintenance_page.dart';
import 'package:app_agendai/features/intro/pages/not_found/not_found_page.dart';
import 'package:app_agendai/features/intro/pages/onboarding/onboarding_page.dart';
import 'package:app_agendai/features/intro/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthPage(),
      routes: [
        GoRoute(
          path: AppRoutes.signUp.path,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: AppRoutes.login.path,
          builder: (context, state) => const LoginPage(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.maintenance,
      builder: (context, state) => const MaintenancePage(),
    ),
    GoRoute(
      path: AppRoutes.forceUpdate,
      builder: (context, state) => const ForceUpdatePage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String maintenance = '/maintenance';
  static const String forceUpdate = '/force-update';
  static const String home = '/home';

  static const AppRoute signUp = AppRoute(
    fullPath: '/auth/signup',
    path: 'signup',
  );

  static const AppRoute login = AppRoute(
    fullPath: '/auth/login',
    path: 'login',
  );
}

class AppRoute {
  const AppRoute({required this.fullPath, required this.path});

  final String fullPath;
  final String path;
}
