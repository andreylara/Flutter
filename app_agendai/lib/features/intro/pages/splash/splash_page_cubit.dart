import 'package:app_agendai/core/device/app_package_info.dart';
import 'package:app_agendai/core/device/app_preferences.dart';
import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/firebase/remote_config/app_remote_config.dart';
import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/features/auth/data/auth_repository.dart';
import 'package:app_agendai/features/intro/pages/splash/splash_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_page_state.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  SplashPageCubit(
    this._actions, {
    AppRemoteConfig? appRemoteConfig,
    AppPackageInfo? appPackageInfo,
    AppPreferences? appPreferences,
    AuthRepository? authRepository,
  })  : _appRemoteConfig = appRemoteConfig ?? getIt(),
        _appPackageInfo = appPackageInfo ?? getIt(),
        _appPreferences = appPreferences ?? getIt(),
        _authRepository = authRepository ?? getIt(),
        super(const SplashPageState());

  SplashPageActions? _actions;

  final AppRemoteConfig _appRemoteConfig;
  final AppPackageInfo _appPackageInfo;
  final AppPreferences _appPreferences;
  final AuthRepository _authRepository;

  Future<void> initialize() async {
    final results = await Future.wait([
      _initRemoteConfig(),
      _checkLoggedUser(),
      Future.delayed(const Duration(seconds: 2))
    ]);

    final appStatus = results[0];

    if (appStatus == AppStatus.maintenance) {
      _actions?.navToMaintenance();
      return;
    } else if (appStatus == AppStatus.forceUpdate) {
      _actions?.navForceUpdate();
      return;
    }

    final shouldShowOnboarding = _appPreferences.shouldShowOnboarding;

    if (shouldShowOnboarding) {
      _actions?.navToOnboarding();
      return;
    }

    final hasLoggedUser = results[1];
    if (hasLoggedUser) {
      _actions?.navToHome();
    } else {
      _actions?.navToAuth();
    }
  }

  Future<AppStatus> _initRemoteConfig() async {
    await _appRemoteConfig.initialize();

    final isMaintenance = _appRemoteConfig.isMaintenance;
    if (isMaintenance) return AppStatus.maintenance;

    final appMinVersion = _appRemoteConfig.appMinVersion;
    final appVersion = await _appPackageInfo.getBuildNumber();

    if (appVersion < appMinVersion) {
      return AppStatus.forceUpdate;
    } else {
      return AppStatus.available;
    }
  }

  Future<bool> _checkLoggedUser() async {
    final result = await _authRepository.validateToken();
    return result is Success;
  }

  void dispose() {
    _actions = null;
  }
}

enum AppStatus { available, maintenance, forceUpdate }
