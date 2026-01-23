import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/auth/data/models/login_response_model.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';

abstract class AuthRemoteDatasource {
  Future<bool> signupUserFromAPI(String email, String password);

  Future<LoginResponseModel> loginUserFromAPI(String email, String password);

  Future<bool> signupOtpVerificationFromApi(String email, String otp);

  Future<String> refreshAccessToken(String refreshToken);

  Future<bool> isEmailExists(String email);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});

  @override
  Future<bool> signupUserFromAPI(String email, String password) async {
    try {
      log("Calling SignUp");
      await Future.delayed(const Duration(seconds: 2));
      final response = await dio.post(
        ApiEndpoints.signup,
        data: {"email": email, "password": password},
      );
      log('Response: ${response.data}');

      return true;
    } catch (e) {
      log('[AuthDatasource] Unknown error', error: e);
      throw ServerException();
    }
  }

  @override
  Future<LoginResponseModel> loginUserFromAPI(
    String email,
    String password,
  ) async {
    try {
      log("Calling Login");
      await Future.delayed(const Duration(seconds: 2));

      final response = await dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      log('Response: ${response.data}');

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      log('[AuthDatasource] Unknown error', error: e);
      throw ServerException();
    }
  }

  @override
  Future<bool> signupOtpVerificationFromApi(String email, String otp) async {
    try {
      log('OTP Verification Started');
      await Future.delayed(const Duration(seconds: 2));

      final response = await dio.post(
        ApiEndpoints.otp,
        data: {"email": email, "otp": otp},
      );

      log('Response: ${response.data}');

      return true;
    } catch (e) {
      log('[AuthDatasource] Unknown error', error: e);
      throw ServerException();
    }
  }

  @override
  Future<String> refreshAccessToken(String refreshToken) async {
    try {
      log('Refreshing access token');
      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      log('Refresh token response: ${response.data}');

      if (response.data['success'] == true &&
          response.data['accessToken'] != null) {
        return response.data['accessToken'] as String;
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('[AuthDatasource] Refresh token error', error: e);
      throw ServerException();
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    try {
      log('Checking email existence');
      final response = await dio.post(
        ApiEndpoints.checkEmail,
        data: {"email": email},
      );

      log('Check email response: ${response.data}');

      if (response.data['success'] == true) {
        return response.data['exists'] == true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('[AuthDatasource] Check email error', error: e);
      throw ServerException();
    }
  }
}
