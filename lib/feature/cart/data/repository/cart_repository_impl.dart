import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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

  @override
  Future<Either<Failure, List<CartEntity>>> deleteCartItem(String id) async {
    try {
      final cartList = await cartDatasource.deleteCartItem(id);
      return right(cartList);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addCartItem(
    String itemId,
    int quantity,
  ) async {
    try {
      final cartItem = await cartDatasource.addCartItem(itemId, quantity);
      return right(cartItem);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateCartItem(String id, int quantity) async {
    try {
      final updateQuantity = await cartDatasource.updateCartItem(id, quantity);
      return right(updateQuantity);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> makePayment(
    double amount,
    String currency,
  ) async {
    try {
      final paymentIntentData = await cartDatasource.getPaymentIntent(
        amount,
        currency,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.dark,
          merchantDisplayName: "Home Decor",
          paymentIntentClientSecret: paymentIntentData['clientSecret'],
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return right(true);
    } catch (e) {
      if (e is StripeException) {
        return left(GeneralFailure()); // Or a more specific failure
      }
      return left(ServerFailure());
    }
  }
}
