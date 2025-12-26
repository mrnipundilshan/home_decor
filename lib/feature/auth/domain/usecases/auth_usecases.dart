import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/auth/domain/repository/auth_repository.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';

class AuthUsecases {
  final AuthRepository authRepository;

  AuthUsecases({required this.authRepository});

  Future<Either<Failure, bool>> signupUser(String email, String password) {
    return authRepository.signupUser(email, password);
  }

  Future<Either<Failure, bool>> otpVerify(String email, String otp) {
    return authRepository.otpVerify(email, otp);
  }
}
