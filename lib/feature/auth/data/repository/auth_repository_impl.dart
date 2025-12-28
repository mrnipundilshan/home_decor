import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_local_datasource.dart';
import 'package:home_decor/feature/auth/data/datasources/auth_remote_datasource.dart';
import 'package:home_decor/feature/auth/domain/repository/auth_repository.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, bool>> signupUser(
    String email,
    String password,
  ) async {
    try {
      await authRemoteDatasource.signupUserFromAPI(email, password);
      return right(true);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> otpVerify(String email, String otp) async {
    try {
      await authRemoteDatasource.signupOtpVerificationFromApi(email, otp);
      return right(true);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
