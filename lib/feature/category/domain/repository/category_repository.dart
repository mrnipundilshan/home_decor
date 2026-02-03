import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/category/domain/entity/item_entity.dart';
import 'package:home_decor/feature/category/domain/failure/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<ItemEntity>>> getTopSellingItemsFromDatasources(
    String category,
  );
}
