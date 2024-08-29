import 'package:app_agendai/core/di/di.dart';
import 'package:app_agendai/features/auth/data/session/session_cubit.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final SessionCubit sessionCubit = getIt();

    final user = sessionCubit.state.loggedUser;
    if (user != null) {
      options.headers['X-Parse-Session-Token'] = user.token;
    }

    handler.next(options);
  }
}
