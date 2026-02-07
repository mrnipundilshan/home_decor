import 'package:dartz/dartz.dart';
import 'package:home_decor/feature/home/domain/entity/item_entity.dart';
import 'package:home_decor/feature/home/domain/failure/failure.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

class ItemUsecases {
  final ItemRepository itemRepository;

  ItemUsecases({required this.itemRepository});

  Future<Either<Failure, List<ItemEntity>>> getTopSelling() {
    return itemRepository.getTopSellingItemsFromDatasources();
  }

  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() {
    return itemRepository.getFavorites();
  }

  Future<Either<Failure, FavoriteEntity>> addFavorite(String itemId) {
    return itemRepository.addFavorite(itemId);
  }

  Future<Either<Failure, void>> removeFavorite(String itemId) {
    return itemRepository.removeFavorite(itemId);
  }
}
