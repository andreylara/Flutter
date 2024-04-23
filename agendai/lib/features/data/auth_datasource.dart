import 'package:agendai/features/auth/models/user.dart';
import 'package:dio/dio.dart';

class AuthDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/functions/',
      headers: {
        'X-Parse-Application-Id': 'co7XvI16yOpunvRM5IAFybGsLcZvYDUlmi5mkWMz',
        'X-Parse-REST-API-Key': 'bI2f3Fd4vNXSDbBeK6z6ezEKYevPHR5ehwUV68yi',
      },
    ),
  );

  Future<User> login({required String email, required String password}) async {
    final response = await _dio.post('/sign-in', data: {
      'email': email,
      'password': password,
    });

    return User.fromMap(response.data['result']);
  }
}
