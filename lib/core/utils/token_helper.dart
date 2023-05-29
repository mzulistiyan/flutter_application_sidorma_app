import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenHelper {
  final secureStorage = const FlutterSecureStorage();

  void saveToken(String value) async {
    await secureStorage.write(key: 'tokenAuth', value: value);
  }

  Future<String> getToken() async {
    String? result = await secureStorage.read(key: 'tokenAuth');
    return result ?? '';
  }
}
