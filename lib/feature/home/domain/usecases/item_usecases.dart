import 'package:home_decor/feature/home/data/repository/item_repository_impl.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';

class ItemUsecases {
  final ItemRepository itemRepository = ItemRepositoryImpl();

  Future<List<ItemEntity>> getTopSelling() {
    return itemRepository.getTopSellingItemsFromDatasources();
  }
}
