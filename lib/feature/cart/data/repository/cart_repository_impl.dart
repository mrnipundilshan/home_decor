import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/cart/data/datasource/cart_datasource.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/domain/failure/failure.dart';
import 'package:home_decor/feature/cart/domain/repository/cart_repository.dart';
import 'package:home_decor/feature/category/data/exception/exceptions.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource cartDatasource;

  CartRepositoryImpl({required this.cartDatasource});

  @override
  Future<Either<Failure, List<CartEntity>>>
  getCartItemsFromDatasources() async {
    try {
      final cartList = await cartDatasource.getCartItemsFromAPI();
      return right(cartList);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
