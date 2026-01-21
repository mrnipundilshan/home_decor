import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
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
      email: json['email'],
      imageUrl: json['profileImage'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      email: entity.email,
      imageUrl: entity.imageUrl,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dob: entity.dob,
      phoneNumber: entity.phoneNumber,
      gender: entity.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'profileImage': imageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
    };
  }
}
