import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getTopSellingItemsFromDatasources();
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites();
  Future<Either<Failure, FavoriteEntity>> addFavorite(String itemId);
  Future<Either<Failure, void>> removeFavorite(String itemId);
}
