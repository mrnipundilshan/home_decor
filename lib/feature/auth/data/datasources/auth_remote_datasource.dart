import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';

abstract class AuthRemoteDatasource {
  Future<bool> signupUserFromAPI(String email, String password);

  Future<bool> signupOtpVerificationFromApi(String email, String otp);
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
  Future<bool> signupOtpVerificationFromApi(String email, String otp) async {
    try {
      log('OTP Verfication Started');
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
}
