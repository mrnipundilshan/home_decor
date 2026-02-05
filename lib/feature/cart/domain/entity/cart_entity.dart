import 'package:home_decor/feature/home/domain/entity/item_entity.dart';

class CartEntity {
  final String? id;
  int? quantity;
  final ItemEntity? itemEntity;

  CartEntity({this.id, this.quantity, this.itemEntity});
}
