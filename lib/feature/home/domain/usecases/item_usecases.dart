import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';

class ItemUsecases {
  final ItemRepository itemRepository;

  ItemUsecases({required this.itemRepository});

  Future<List<ItemEntity>> getTopSelling() {
    return itemRepository.getTopSellingItemsFromDatasources();
  }
}
