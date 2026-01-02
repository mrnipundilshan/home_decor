import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_decor/core/network/auth_interceptor.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_local_datasource.dart';

class DioClient {
  final Dio dio;

  DioClient({required AuthLocalDatasource authLocalDatasource})
    : dio = Dio(
        BaseOptions(
          baseUrl: dotenv.env['API_BASE_URL'] ?? '',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    // Add auth interceptor to automatically attach bearer token and handle token refresh
    dio.interceptors.add(
      AuthInterceptor(authLocalDatasource: authLocalDatasource, dio: dio),
    );
  }
}
