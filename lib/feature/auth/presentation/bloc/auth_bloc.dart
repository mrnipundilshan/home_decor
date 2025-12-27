import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;
  AuthBloc({required this.authUsecases}) : super(AuthInitial()) {
    on<SinginButtonClickedEvent>(_singinButtonClickedEvent);

    on<SignupButtonClickedEvent>(_signupButtonClickedEvent);

    on<SigupOtpVerifyButtonClickedEvent>(_signupOtpVerifyButtonClickedEvent);

    on<AuthEvent>((event, emit) {});
  }

  FutureOr<void> _singinButtonClickedEvent(
    SinginButtonClickedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthLoadingState());

    emit(SignUpSuccessState());
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
}
