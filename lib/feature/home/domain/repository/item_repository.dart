import 'package:home_decor/feature/home/domain/entity/item_entity.dart';

abstract class ItemRepository {
  Future<List<ItemEntity>> getTopSellingItemsFromDatasources();
}
