import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SinginButtonClickedEvent>(_singinButtonClickedEvent);

    on<SignupButtonClickedEvent>(_signupButtonClickedEvent);

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
  ) {
    emit(AuthLoadingState());
    emit(SignUpSuccessState());
  }
}
