import 'package:home_decor/feature/home/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    super.title,
    super.subtitle,
    super.imageUrl,
    super.price,
    super.rating,
    super.uuid,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      uuid: json['id'],
    );
  }
}
