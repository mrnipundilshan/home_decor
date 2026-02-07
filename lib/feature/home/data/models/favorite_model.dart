import 'package:home_decor/feature/home/data/models/item_model.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel({
    required super.id,
    required super.userId,
    required super.itemId,
    super.item,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['userId'],
      itemId: json['itemId'],
      item: json['item'] != null ? ItemModel.fromJson(json['item']) : null,
    );
  }
}
