part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class SignupButtonClickedEvent extends AuthEvent {
  final String email;
  final String password;

  const SignupButtonClickedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SigupOtpVerifyButtonClickedEvent extends AuthEvent {
  final String email;
  final String otp;

  const SigupOtpVerifyButtonClickedEvent({
    required this.email,
    required this.otp,
  });
}

class SinginButtonClickedEvent extends AuthEvent {
  final String email;
  final String password;

  const SinginButtonClickedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogOutButtonClickedEvent extends AuthEvent {}
