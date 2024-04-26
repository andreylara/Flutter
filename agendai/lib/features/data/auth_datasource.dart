import 'package:agendai/core/helpers/result.dart';
import 'package:agendai/features/auth/models/user.dart';
import 'package:agendai/features/data/results/login_failed_result.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/functions/',
      headers: {
        'X-Parse-Application-Id': 'co7XvI16yOpunvRM5IAFybGsLcZvYDUlmi5mkWMz',
        'X-Parse-REST-API-Key': 'bI2f3Fd4vNXSDbBeK6z6ezEKYevPHR5ehwUV68yi',
      },
    ),
  )...interceptors.add(PrettyDioLogger());

  Future<Result<LoginFailedResult, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post('/sign-in', data: {
        'email': email,
        'password': password,
      });

      return Success(User.fromMap(response.data['result']));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Failure(LoginFailedResult.invalidCredentials);
      } else {
        return const Failure(LoginFailedResult.unknownError);
      }
    } catch (_) {
      return const Failure(LoginFailedResult.unknownError);
    }
  }
}