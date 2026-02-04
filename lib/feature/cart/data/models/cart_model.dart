import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    super.title,
    super.subtitle,
    super.imageUrl,
    super.category,
    super.price,
    super.rating,
    super.uuid,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
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
