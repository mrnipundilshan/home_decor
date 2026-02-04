import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/domain/failure/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCartItemsFromDatasources();
}
