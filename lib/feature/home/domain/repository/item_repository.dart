import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getTopSellingItemsFromDatasources();
}
