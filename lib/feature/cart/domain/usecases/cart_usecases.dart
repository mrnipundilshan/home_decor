import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/domain/failure/failure.dart';
import 'package:home_decor/feature/cart/domain/repository/cart_repository.dart';

class CartUsecases {
  final CartRepository cartRepository;

  CartUsecases({required this.cartRepository});

  Future<Either<Failure, List<CartEntity>>> getCartItems() {
    return cartRepository.getCartItemsFromDatasources();
  }

  Future<Either<Failure, List<CartEntity>>> deleteCartItem(String id) {
    return cartRepository.deleteCartItem(id);
  }

  Future<Either<Failure, CartEntity>> addCartItem(String itemId, int quantity) {
    return cartRepository.addCartItem(itemId, quantity);
  }

  Future<Either<Failure, bool>> updateCartItem(String id, int quantity) {
    return cartRepository.updateCartItem(id, quantity);
  }
}
