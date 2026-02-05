import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/cart/data/models/cart_model.dart';
import 'package:home_decor/feature/category/data/exception/exceptions.dart';

abstract class CartDatasource {
  Future<List<CartModel>> getCartItemsFromAPI();

  Future<bool> deleteCartItem(String id);
}

class CartDatasourceImpl implements CartDatasource {
  final Dio dio;

  CartDatasourceImpl({required this.dio});

  @override
  Future<List<CartModel>> getCartItemsFromAPI() async {
    log("Calling Cart List");
    await Future.delayed(const Duration(seconds: 4));
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
  Future<bool> deleteCartItem(String id) async {
    log("Calling Delete Cart Item");
    await Future.delayed(const Duration(seconds: 4));
    final response = await dio.delete('${ApiEndpoints.cart}/$id');

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
}
