part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitialEvent extends CartEvent {
  const CartInitialEvent();
}

class CartDeleteEvent extends CartEvent {
  final String id;

  const CartDeleteEvent({required this.id});
}
