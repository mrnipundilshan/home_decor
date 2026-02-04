import 'package:home_decor/feature/category/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    super.title,
    super.subtitle,
    super.imageUrl,
    super.category,
    super.price,
    super.rating,
    super.uuid,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      subtitle: json['subtitle'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      uuid: json['id'],
    );
  }
}
