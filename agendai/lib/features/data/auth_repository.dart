import 'package:agendai/features/data/auth_datasource.dart';

class AuthRepository {
  final AuthDatasource _datasource = AuthDatasource();

  Future<void> login({required String email, required String password}) {
    return _datasource.login(email: email, password: password);
  }
}
