import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  final secureStorage = const FlutterSecureStorage();
  final String keyAccessToken = 'tokenAuthSidorma';
  final String role = 'mahasiswa';

  void saveToken(String value) async {
    await secureStorage.write(key: 'tokenAuthSidorma', value: value);
  }

  void saveRole(String value) async {
    await secureStorage.write(key: 'role', value: value);
  }

  Future<String> getRole() async {
    String? result = await secureStorage.read(key: 'role');
    return result ?? '';
  }

  Future<String> getToken() async {
    String? result = await secureStorage.read(key: 'tokenAuthSidorma');
    return result ?? '';
  }

  Future<bool> containsKey({required String key}) async {
    return await secureStorage.containsKey(key: key);
  }
}
