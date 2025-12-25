import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_decor/feature/home/data/models/item_model.dart';

abstract class ItemDatasource {
  Future<List<ItemModel>> getTopSellingItemsFromAPI();
}

class ItemDatasourceImpl implements ItemDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['API_BASE_URL'] ?? '',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  @override
  Future<List<ItemModel>> getTopSellingItemsFromAPI() async {
    log("Loading API");
    //await Future.delayed(const Duration(seconds: 4));
    final response = await _dio.get('topselling');

    // final responseBody = json.decode(response.data);
    final responseBody = response.data;

    final topSellingItemList = (responseBody as List)
        .map((json) => ItemModel.fromJson(json))
        .toList();

    return topSellingItemList;
  }
}
