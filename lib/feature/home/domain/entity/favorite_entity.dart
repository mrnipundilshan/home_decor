import 'package:home_decor/feature/home/domain/entity/item_entity.dart';

class FavoriteEntity {
  final String id;
  final String userId;
  final String itemId;
  final ItemEntity? item;

  FavoriteEntity({
    required this.id,
    required this.userId,
    required this.itemId,
    this.item,
  });
}
