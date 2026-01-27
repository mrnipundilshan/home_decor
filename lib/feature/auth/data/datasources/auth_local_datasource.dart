import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';

abstract class AuthLocalDatasource {
  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<bool> clearTokens();

  Future<bool> isLoggedIn();

  Future<void> saveEmail(String email);

  Future<String?> getEmail();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage flutterSecureStorage;

  AuthLocalDatasourceImpl({required this.flutterSecureStorage});

  static const _accessKey = 'ACCESS_TOKEN';
  static const _refreshKey = 'REFRESH_TOKEN';
  static const _email = 'Email';

  @override
  Future<bool> clearTokens() async {
    try {
      await flutterSecureStorage.deleteAll();
      return true;
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await flutterSecureStorage.read(key: _accessKey);
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await flutterSecureStorage.read(key: _refreshKey);
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    try {
      await flutterSecureStorage.write(key: _accessKey, value: accessToken);
      await flutterSecureStorage.write(key: _refreshKey, value: refreshToken);
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await flutterSecureStorage.read(key: _accessKey);
      final isLoggedIn = token != null && token.isNotEmpty;
      return isLoggedIn;
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<void> saveEmail(String email) async {
    try {
      await flutterSecureStorage.write(key: _email, value: email);
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }

  @override
  Future<String?> getEmail() async {
    try {
      return await flutterSecureStorage.read(key: _email);
    } catch (e) {
      log('Unknown error', error: e);
      throw CacheException();
    }
  }
}
