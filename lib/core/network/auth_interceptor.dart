import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_local_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDatasource authLocalDatasource;
  final Dio dio;

  AuthInterceptor({required this.authLocalDatasource, required this.dio});

  // List of public endpoints that don't require authentication
  static const List<String> publicEndpoints = [
    ApiEndpoints.signup,
    ApiEndpoints.login,
    ApiEndpoints.otp,
    ApiEndpoints.refreshToken,
    ApiEndpoints.checkEmail,
  ];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if this is a public endpoint
    final isPublicEndpoint = publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    // Only add token for authenticated endpoints
    if (!isPublicEndpoint) {
      try {
        final token = await authLocalDatasource.getAccessToken();

        if (token != null && token.isNotEmpty) {
          //  print(token);
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        // If token retrieval fails, continue without token
        // The API will return 401 if token is required
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if this is a 401 error
    if (err.response?.statusCode == 401) {
      final requestOptions = err.requestOptions;

      // Check if this is a public endpoint - don't retry for public endpoints
      final isPublicEndpoint = publicEndpoints.any(
        (endpoint) => requestOptions.path.contains(endpoint),
      );

      if (isPublicEndpoint) {
        // For public endpoints, just pass through the error
        handler.next(err);
        return;
      }

      // Check if we've already retried this request (prevent infinite loops)
      final hasRetried = requestOptions.extra['retried'] == true;
      if (hasRetried) {
        // Already retried once, don't retry again
        handler.next(err);
        return;
      }

      try {
        // Get refresh token from storage
        final refreshToken = await authLocalDatasource.getRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          // No refresh token available, can't refresh
          handler.next(err);
          return;
        }

        // Call refresh token API directly using a separate Dio instance
        // to avoid circular dependency and interceptor loops
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: requestOptions.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {'Content-Type': 'application/json'},
          ),
        );

        final refreshResponse = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {"refreshToken": refreshToken},
        );

        // Extract new access token from response
        if (refreshResponse.data['success'] == true &&
            refreshResponse.data['accessToken'] != null) {
          final newAccessToken = refreshResponse.data['accessToken'] as String;

          // Save the new access token (keep the same refresh token)
          await authLocalDatasource.saveTokens(newAccessToken, refreshToken);

          // Update the original request with the new token
          requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          // Mark this request as retried to prevent infinite loops
          requestOptions.extra['retried'] = true;

          // Retry the request with the same Dio instance (which has all interceptors)
          final response = await dio.fetch(requestOptions);

          // Successfully retried, return the response
          handler.resolve(response);
        } else {
          // Refresh token response was invalid
          handler.next(err);
        }
      } catch (e) {
        // Refresh token failed or other error occurred
        // Don't retry again, just pass through the original error
        handler.next(err);
      }
    } else {
      // Not a 401 error, pass through
      handler.next(err);
    }
  }
}
