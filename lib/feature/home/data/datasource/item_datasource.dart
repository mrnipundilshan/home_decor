import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/home/data/models/item_model.dart';
import 'package:home_decor/feature/home/data/models/favorite_model.dart';

abstract class ItemDatasource {
  Future<List<ItemModel>> getTopSellingItemsFromAPI();
  Future<List<FavoriteModel>> getFavorites();
  Future<FavoriteModel> addFavorite(String itemId);
  Future<void> removeFavorite(String itemId);
}

class ItemDatasourceImpl implements ItemDatasource {
  final Dio dio;

  ItemDatasourceImpl({required this.dio});

  @override
  Future<List<ItemModel>> getTopSellingItemsFromAPI() async {
    log("Calling Top Selling API");
    await Future.delayed(const Duration(seconds: 3));
    final response = await dio.get(ApiEndpoints.topSelling);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data;
      final topSellingItemList = (responseBody as List)
          .map((json) => ItemModel.fromJson(json))
          .toList();

      return topSellingItemList;
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    log("Calling Get Favorites API");
    await Future.delayed(const Duration(seconds: 3));
    final response = await dio.get(ApiEndpoints.favorites);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = response.data['data'] as List;
      return responseBody.map((json) => FavoriteModel.fromJson(json)).toList();
    }
  }

  @override
  Future<FavoriteModel> addFavorite(String itemId) async {
    log("Calling Add Favorite API");
    final response = await dio.post(
      ApiEndpoints.favorites,
      data: {'itemId': itemId},
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw ServerException();
    } else {
      return FavoriteModel.fromJson(response.data['data']);
    }
  }

  @override
  Future<void> removeFavorite(String itemId) async {
    log("Calling Remove Favorite API");
    final response = await dio.delete("${ApiEndpoints.favorites}/$itemId");

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
