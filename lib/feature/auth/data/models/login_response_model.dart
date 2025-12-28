import 'package:home_decor/feature/auth/data/models/user_model.dart';

class LoginResponseModel {
  final bool success;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}
