import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/cart/data/models/cart_model.dart';
import 'package:home_decor/feature/category/data/exception/exceptions.dart';

abstract class CartDatasource {
  Future<List<CartModel>> getCartItemsFromAPI();

  Future<List<CartModel>> deleteCartItem(String id);

  Future<bool> updateCartItem(String id, int quantity);

  Future<CartModel> addCartItem(String itemId, int quantity);

  Future<Map<String, dynamic>> getPaymentIntent(double amount, String currency);
}

class CartDatasourceImpl implements CartDatasource {
  final Dio dio;

  CartDatasourceImpl({required this.dio});

  @override
  Future<List<CartModel>> getCartItemsFromAPI() async {
    log("Calling Cart List");
    await Future.delayed(const Duration(seconds: 2));
    final response = await dio.get(ApiEndpoints.cart);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data;

      if (responseBody['success'] == true) {
        final cartList = (responseBody['data'] as List)
            .map((json) => CartModel.fromJson(json))
            .toList();
        return cartList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<CartModel>> deleteCartItem(String id) async {
    log("Calling Delete Cart Item");
    await Future.delayed(const Duration(seconds: 2));
    final response = await dio.delete('${ApiEndpoints.cart}/$id');

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data;

      if (responseBody['success'] == true) {
        final cartList = await getCartItemsFromAPI();
        return cartList;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<bool> updateCartItem(String id, int quantity) async {
    log("Calling Update Cart Item");

    final response = await dio.put(
      '${ApiEndpoints.cart}/$id',
      data: {'quantity': quantity},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data;

      if (responseBody['success'] == true) {
        return true;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<CartModel> addCartItem(String itemId, int quantity) async {
    log("Calling Add Cart Item");
    await Future.delayed(const Duration(seconds: 2));
    final response = await dio.post(
      ApiEndpoints.cart,
      data: {'itemId': itemId, 'quantity': quantity},
    );

    if (response.statusCode != 201) {
      throw ServerException();
    } else {
      final responseBody = response.data;

      if (responseBody['success'] == true) {
        return CartModel.fromJson(responseBody['data']);
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<Map<String, dynamic>> getPaymentIntent(
    double amount,
    String currency,
  ) async {
    try {
      final body = {'amount': amount, 'currency': currency};
      final response = await dio.post(ApiEndpoints.payment, data: body);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw ServerException();
    }
  }
}
