import 'package:home_decor/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
    );
  }
}
