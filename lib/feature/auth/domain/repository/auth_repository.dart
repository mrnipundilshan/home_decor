import 'package:dartz/dartz.dart';

import 'package:home_decor/feature/auth/domain/entity/user_entity.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signupUser(String email, String password);

  Future<Either<Failure, UserEntity>> loginUser(String email, String password);

  Future<Either<Failure, bool>> otpVerify(String email, String otp);
}
