import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/data/datasource/item_datasource.dart';
import 'package:home_decor/feature/home/data/exception/exceptions.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDatasource itemDatasource;

  ItemRepositoryImpl({required this.itemDatasource});

  @override
  Future<Either<Failure, List<ItemEntity>>>
  getTopSellingItemsFromDatasources() async {
    try {
      final topSellingitems = await itemDatasource.getTopSellingItemsFromAPI();
      return right(topSellingitems);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() async {
    try {
      final favorites = await itemDatasource.getFavorites();
      return right(favorites);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, FavoriteEntity>> addFavorite(String itemId) async {
    try {
      final favorite = await itemDatasource.addFavorite(itemId);
      return right(favorite);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String itemId) async {
    try {
      await itemDatasource.removeFavorite(itemId);
      return right(null);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
