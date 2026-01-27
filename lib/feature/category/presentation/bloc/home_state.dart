part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeTopSellingLoadingState extends HomeState {}

class HomeTopSellingErrorState extends HomeState {}

class HomeTopSellingLoadedState extends HomeState {
  final List<ItemEntity> topSellingItems;

  const HomeTopSellingLoadedState({required this.topSellingItems});
}
