import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/category/data/datasource/category_datasource.dart';
import 'package:home_decor/feature/category/data/exception/exceptions.dart';
import 'package:home_decor/feature/category/domain/entity/item_entity.dart';
import 'package:home_decor/feature/category/domain/failure/failure.dart';
import 'package:home_decor/feature/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource categoryDatasource;

  CategoryRepositoryImpl({required this.categoryDatasource});

  @override
  Future<Either<Failure, List<ItemEntity>>> getTopSellingItemsFromDatasources(
    String category,
  ) async {
    try {
      final itemList = await categoryDatasource.getTopSellingItemsFromAPI(
        category,
      );
      return right(itemList);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
