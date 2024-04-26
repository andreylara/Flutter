import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/auth/models/user.dart';
import 'package:agendai/features/data/auth_datasource.dart';
import 'package:agendai/features/data/results/login_failed_result.dart';

class AuthRepository {
  final AuthDatasource _datasource = AuthDatasource();

  Future<Result<LoginFailedResult, User>> login(
      {required String email, required String password}) async {
    final result = await _datasource.login(email: email, password: password);
    return result;
  }
}
