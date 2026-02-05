part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartEntity> cartList;

  const CartLoadedState({required this.cartList});
}

class CartAddedSuccessState extends CartState {}
