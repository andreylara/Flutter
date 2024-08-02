import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorage {

  AppSecureStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> getSessionToken() {
    return Future.value('r:d61add6fdca2bc7c9a58c32e0484a746');
    return _secureStorage.read(key: 'sessionToken');
  }

}