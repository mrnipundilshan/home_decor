import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:home_decor/feature/home/data/models/item_model.dart';

abstract class ItemDatasource {
  Future<List<ItemModel>> getTopSellingItemsFromAPI();
}

class ItemDatasourceImpl implements ItemDatasource {
  @override
  Future<List<ItemModel>> getTopSellingItemsFromAPI() async {
    log("Loading Local Json");
    await Future.delayed(const Duration(seconds: 4));
    final String response = await rootBundle.loadString(
      'assets/topselling.json',
    );

    final List<dynamic> responseBody = json.decode(response);

    final topSellingItemList = responseBody
        .map((json) => ItemModel.fromJson(json))
        .toList();

    return topSellingItemList;
  }
}
