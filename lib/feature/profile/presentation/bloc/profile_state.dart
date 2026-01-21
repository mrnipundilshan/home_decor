part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileDataFetchLoadingState extends ProfileState {}

class ProfileDataFetchSuccessState extends ProfileState {
  final ProfileEntity profile;

  const ProfileDataFetchSuccessState({required this.profile});
}

class ProfileErrorState extends ProfileState {}

class ProfileDataSetLoadingState extends ProfileState {}

class ProfileUpdateSuccessState extends ProfileState {}
