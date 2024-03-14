const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoints {
  static const String sigin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCategories = '$baseUrl/get-category-list';
}
