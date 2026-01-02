import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/profile/domain/usecases/profile_usecases.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileUsecases profileUsecases;
  ProfileBloc({required this.profileUsecases}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<FetchUserDetailsEvent>(_fetchUserDetailsEvent);
  }

  FutureOr<void> _fetchUserDetailsEvent(
    FetchUserDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await profileUsecases.getProfileDetails();
  }
}
