import 'package:home_decor/feature/home/data/datasource/item_datasource.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDatasource itemDatasource;

  ItemRepositoryImpl({required this.itemDatasource});

  @override
  Future<List<ItemEntity>> getTopSellingItemsFromDatasources() async {
    final topSellingitems = await itemDatasource.getTopSellingItemsFromAPI();
    return topSellingitems;
  }
}
