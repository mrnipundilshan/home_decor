import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/category/domain/entity/item_entity.dart';
import 'package:home_decor/feature/category/domain/failure/failure.dart';
import 'package:home_decor/feature/category/domain/repository/category_repository.dart';

class CategoryUsecases {
  final CategoryRepository categoryRepository;

  CategoryUsecases({required this.categoryRepository});

  Future<Either<Failure, List<ItemEntity>>> getTopSelling() {
    return categoryRepository.getTopSellingItemsFromDatasources();
  }
}
