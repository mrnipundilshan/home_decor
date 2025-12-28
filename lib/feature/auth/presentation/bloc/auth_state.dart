part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthOtpSentSuccessState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserEntity? user;

  const LoginSuccessState({this.user});

  @override
  List<Object> get props => user != null ? [user!] : [];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
