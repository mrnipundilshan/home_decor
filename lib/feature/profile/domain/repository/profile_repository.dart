import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';
import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getUserProfileDetails();
}
