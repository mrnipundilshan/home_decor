import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    required super.email,
    super.imageUrl,
    super.firstName,
    super.lastName,
    super.dob,
    super.phoneNumber,
    super.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      imageUrl: json['profileImage'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
    );
  }
}
