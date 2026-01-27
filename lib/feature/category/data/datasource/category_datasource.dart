import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:home_decor/core/data/api_endpoints.dart';
import 'package:home_decor/feature/category/data/exception/exceptions.dart';
import 'package:home_decor/feature/category/data/models/item_model.dart';

abstract class CategoryDatasource {
  Future<List<ItemModel>> getTopSellingItemsFromAPI();
}

class CategoryDatasourceImpl implements CategoryDatasource {
  final Dio dio;

  CategoryDatasourceImpl({required this.dio});

  @override
  Future<List<ItemModel>> getTopSellingItemsFromAPI() async {
    log("Calling Category List");
    await Future.delayed(const Duration(seconds: 4));
    final response = await dio.get(ApiEndpoints.items);

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      //final responseBody = json.decode(response.data);
      final responseBody = response.data;
      print(responseBody);
      final itemList = (responseBody as List)
          .map((json) => ItemModel.fromJson(json))
          .toList();

      return itemList;
    }
  }
}
