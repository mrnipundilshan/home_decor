class ProfileEntity {
  final String email;
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? phoneNumber;
  final String? gender;

  ProfileEntity({
    required this.email,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.gender,
  });
}
