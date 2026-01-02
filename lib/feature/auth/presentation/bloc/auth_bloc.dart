import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/auth/domain/entity/user_entity.dart';
import 'package:home_decor/feature/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;
  AuthBloc({required this.authUsecases}) : super(AuthInitial()) {
    on<SinginButtonClickedEvent>(_singinButtonClickedEvent);

    on<SignupButtonClickedEvent>(_signupButtonClickedEvent);

    on<SigupOtpVerifyButtonClickedEvent>(_signupOtpVerifyButtonClickedEvent);

    on<LogOutButtonClickedEvent>(_logOutButtonClickedEvent);

    on<AuthEvent>((event, emit) {});

    on<CheckLoggedEvent>(_checkLoggedEvent);
  }

  FutureOr<void> _singinButtonClickedEvent(
    SinginButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final failureOrUser = await authUsecases.loginUser(
      event.email,
      event.password,
    );

    failureOrUser.fold(
      (failure) => emit(AuthErrorState(message: "Connection Error")),
      (user) => emit(LoginSuccessState(user: user)),
    );
  }

  FutureOr<void> _signupButtonClickedEvent(
    SignupButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final failureOrOtp = await authUsecases.signupUser(
      event.email,
      event.password,
    );

    failureOrOtp.fold(
      (failure) => emit(AuthErrorState(message: "Connection Error")),

      (right) => emit(AuthOtpSentSuccessState()),
    );
  }

  FutureOr<void> _signupOtpVerifyButtonClickedEvent(
    SigupOtpVerifyButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final failureOrSuccess = await authUsecases.otpVerify(
      event.email,
      event.otp,
    );

    failureOrSuccess.fold(
      (failure) => emit(AuthErrorState(message: "Connection Error")),
      (right) => emit(SignUpSuccessState()),
    );
  }

  FutureOr<void> _logOutButtonClickedEvent(
    LogOutButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final failureOrLogout = await authUsecases.logout();

    failureOrLogout.fold(
      (failure) => emit(AuthErrorState(message: "Try Again")),
      (right) => emit(AuthUnauthonticatedState()),
    );
  }

  FutureOr<void> _checkLoggedEvent(
    CheckLoggedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final isLoggedIn = await authUsecases.isLogIn();

    isLoggedIn.fold((failure) => emit(AuthUnauthonticatedState()), (
      isLoggedIn,
    ) {
      if (isLoggedIn) {
        emit(AuthonticatedState());
      } else {
        emit(AuthUnauthonticatedState());
      }
    });
  }
}
