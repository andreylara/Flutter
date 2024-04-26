class LoginController {
  final AuthRepository authRepository = AuthRepository();

  Future<void> login() async {
    final result = await authRepository.login(email: 'email', password: '1234');
    switch (result) {
      case Success(object: final user):
        print('success');
      case Failure(error: final error):
        print(error);
    }
  }
}
