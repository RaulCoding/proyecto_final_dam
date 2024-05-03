import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  Future<String?> readAccessToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }

  Future<void> saveTokens(String? accessToken, String? refreshToken) async {
    await _storage.write(key: accessTokenKey, value: accessToken);
    await _storage.write(key: refreshTokenKey, value: refreshToken);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
  }
}
