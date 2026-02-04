import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/home/data/models/item_model.dart';

class CartModel extends CartEntity {
  CartModel({super.id, super.quantity, super.itemEntity});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      quantity: json['quantity'],
      itemEntity: ItemModel.fromJson(json['item']),
    );
  }
}
