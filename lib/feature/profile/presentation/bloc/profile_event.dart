part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserDetailsEvent extends ProfileEvent {}

class SetUserDetailsEvent extends ProfileEvent {
  final ProfileEntity profileEntity;

  const SetUserDetailsEvent({required this.profileEntity});
}
