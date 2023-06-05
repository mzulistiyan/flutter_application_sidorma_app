import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  final secureStorage = const FlutterSecureStorage();

  void saveToken(String value) async {
    await secureStorage.write(key: 'tokenAuth', value: value);
  }

  void saveRole(String value) async {
    await secureStorage.write(key: 'role', value: value);
  }

  Future<String> getRole() async {
    String? result = await secureStorage.read(key: 'role');
    return result ?? '';
  }

  Future<String> getToken() async {
    String? result = await secureStorage.read(key: 'tokenAuth');
    return result ?? '';
  }
}
