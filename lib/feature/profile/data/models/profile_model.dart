import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({required super.id, required super.email});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(id: json['id'], email: json['email']);
  }
}
