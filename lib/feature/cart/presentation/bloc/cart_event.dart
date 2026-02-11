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

class CartAddEvent extends CartEvent {
  final String itemId;
  final int quantity;

  const CartAddEvent({required this.itemId, required this.quantity});
}

class CartUpdateEvent extends CartEvent {
  final String id;
  final int quantity;

  const CartUpdateEvent({required this.id, required this.quantity});
}

class CartStripePaymentEvent extends CartEvent {
  final double amount;
  final String currency;

  const CartStripePaymentEvent({required this.amount, required this.currency});

  @override
  List<Object> get props => [amount, currency];
}
