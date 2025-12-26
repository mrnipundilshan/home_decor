import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';

abstract class AuthDatasource {
  Future<bool> signupUserFromAPI(String email, String password);

  Future<bool> signupOtpVerificationFromApi(String email, String otp);
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;

  AuthDatasourceImpl({required this.dio});

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
    } on DioException catch (e) {
      log('[AuthDatasource] Dio error', error: e.response?.data ?? e.message);
      throw _handleDioError(e);
    } catch (e) {
      log('[AuthDatasource] Unknown error', error: e);
      rethrow;
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
    } on DioException catch (e) {
      log('[AuthDatasource] Dio error', error: e.response?.data ?? e.message);
      throw _handleDioError(e);
    } catch (e) {
      log('[AuthDatasource] Unknown error', error: e);
      rethrow;
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return Exception('Invalid signup data');
      case 409:
        return Exception('User already exists');
      case 500:
        return Exception('Server error');
      default:
        return Exception('Something went wrong');
    }
  }
}
