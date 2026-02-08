import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/domain/usecases/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecases cartUsecases;

  CartBloc({required this.cartUsecases}) : super(HomeInitial()) {
    on<CartEvent>((event, emit) {});

    on<CartInitialEvent>(_cartInitialEvent);
    on<CartDeleteEvent>(_cartDeleteEvent);
    on<CartAddEvent>(_cartAddEvent);
    on<CartUpdateEvent>(_cartUpdateEvent);
  }

  FutureOr<void> _cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());

    final failureOrCartList = await cartUsecases.getCartItems();

    failureOrCartList.fold(
      (failure) => emit(CartErrorState()),
      (cartList) => emit(CartLoadedState(cartList: cartList)),
    );
  }

  FutureOr<void> _cartDeleteEvent(
    CartDeleteEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());

    final failureOrCartList = await cartUsecases.deleteCartItem(event.id);

    failureOrCartList.fold(
      (failure) => emit(CartErrorState()),
      (cartList) => emit(CartLoadedState(cartList: cartList)),
    );
  }

  FutureOr<void> _cartAddEvent(
    CartAddEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());

    final failureOrItemAdded = await cartUsecases.addCartItem(
      event.itemId,
      event.quantity,
    );

    failureOrItemAdded.fold(
      (failure) => emit(CartErrorState()),
      (itemAdded) => emit(CartAddedSuccessState()),
    );
  }

  FutureOr<void> _cartUpdateEvent(
    CartUpdateEvent event,
    Emitter<CartState> emit,
  ) async {
    await cartUsecases.updateCartItem(event.id, event.quantity);
  }
}
