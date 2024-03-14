import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    // Headers da requisição
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'PoE9RJp29Z2hntuDjyybg5OugPyWPRNSh0wuUozg',
        'X-Parse-REST-API-Key': 'au38hlIGpzRu3LGzZdWkB7DwSIxgz2IZvN7TnCYT',
      });
    Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );
      // Retorno do resultado do backend
      return response.data;
    } on DioException catch (error) {
      // Retorno do erro do dio request
      return error.response?.data ?? {};
    } catch (error) {
      // Retorno de erro generalizado
      return {};
    }
  }
}
