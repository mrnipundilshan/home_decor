part of 'cart_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  final List<ItemEntity> itemList;

  const CategoryLoadedState({required this.itemList});
}
