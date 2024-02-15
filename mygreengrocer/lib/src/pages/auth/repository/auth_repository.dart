import 'package:mygreengrocer/src/constants/endponts.dart';
import 'package:mygreengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future signIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.sigin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (result['result'] != null) {
      print('SignIn funcionou!');
    } else {
      print('SignIn deu erro!');
    }
  }
}
