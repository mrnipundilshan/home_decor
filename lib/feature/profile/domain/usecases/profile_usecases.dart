import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';
import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';
import 'package:home_decor/feature/profile/domain/repository/profile_repository.dart';

class ProfileUsecases {
  final ProfileRepository profileRepository;

  ProfileUsecases({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> getProfileDetails() {
    return profileRepository.getUserProfileDetails();
  }
}
