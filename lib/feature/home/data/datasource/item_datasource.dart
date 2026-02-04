import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/home/data/models/item_model.dart';

abstract class ItemDatasource {
  Future<List<ItemModel>> getTopSellingItemsFromAPI();
}

class ItemDatasourceImpl implements ItemDatasource {
  final Dio dio;

  ItemDatasourceImpl({required this.dio});

  @override
  Future<List<ItemModel>> getTopSellingItemsFromAPI() async {
    log("Calling Top Selling API");
    await Future.delayed(const Duration(seconds: 4));
    final response = await dio.get(ApiEndpoints.topSelling);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      // final responseBody = json.decode(response.data);
      final responseBody = response.data;
      // print(responseBody);
      final topSellingItemList = (responseBody as List)
          .map((json) => ItemModel.fromJson(json))
          .toList();

      return topSellingItemList;
    }
  }
}
