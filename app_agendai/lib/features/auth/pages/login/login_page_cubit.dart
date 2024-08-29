import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/core/helpers/result.dart';
import 'package:app_agendai/core/widgets/alert/alert_area_cubit.dart';
import 'package:app_agendai/features/auth/data/results/login_failed.dart';
import 'package:app_agendai/features/auth/data/session/session_cubit.dart';
import 'package:app_agendai/features/auth/models/email.dart';
import 'package:app_agendai/features/auth/models/password.dart';
import 'package:app_agendai/features/auth/pages/login/login_page_actions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit(this._actions,
      {SessionCubit? sessionCubit, AlertAreaCubit? alertAreaCubit})
      : _sessionCubit = sessionCubit ?? getIt(),
        _alertAreaCubit = alertAreaCubit ?? getIt(),
        super(const LoginPageState.empty());

  final LoginPageActions _actions;
  final SessionCubit _sessionCubit;
  final AlertAreaCubit _alertAreaCubit;

  Future<void> onLoginPressed() async {
    emit(state.copyWith(isLoading: true));

    final result = await _sessionCubit.login(
      email: state.email.value,
      password: state.password.value,
    );

    switch (result) {
      case Success():
        _actions.navToHome();
      case Failure(:final error):
        _alertAreaCubit.showAlert(
          Alert.error(
            title: switch (error) {
              LoginFailed.invalidCredentials => 'E-mail/Senha inválidos.',
              LoginFailed.offline =>
                'Verifique sua conexão com a internet e tente novamente!',
              _ => 'Falha ao realizar o login. Por favor, tente novamente.'
            },
          ),
        );
    }

    emit(state.copyWith(isLoading: false));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith(email: Email.dirty(value)));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: Password.dirty(value, false)));
  }
}
