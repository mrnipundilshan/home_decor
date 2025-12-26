import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> signupUser(String email, String password);
}
