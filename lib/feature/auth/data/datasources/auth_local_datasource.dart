import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDatasource {
  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<void> clearTokens();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage flutterSecureStorage;

  AuthLocalDatasourceImpl({required this.flutterSecureStorage});

  static const _accessKey = 'ACCESS_TOKEN';
  static const _refreshKey = 'REFRESH_TOKEN';

  @override
  Future<void> clearTokens() async {
    await flutterSecureStorage.deleteAll();
  }

  @override
  Future<String?> getAccessToken() async {
    return await flutterSecureStorage.read(key: _accessKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await flutterSecureStorage.read(key: _refreshKey);
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await flutterSecureStorage.write(key: _accessKey, value: accessToken);
    await flutterSecureStorage.write(key: _refreshKey, value: refreshToken);
  }
}
