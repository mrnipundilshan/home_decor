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
}
