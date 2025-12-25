import 'package:home_decor/feature/home/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    required super.price,
    required super.rating,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}
