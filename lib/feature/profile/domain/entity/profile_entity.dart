class ProfileEntity {
  final String id;
  final String email;
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final DateTime? dob;
  final String? phoneNumber;
  final String? gender;

  ProfileEntity({
    required this.id,
    required this.email,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.gender,
  });
}
