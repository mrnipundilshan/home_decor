import 'package:equatable/equatable.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteEntity> favorites;
  final Set<String> favoriteIds;

  const FavoritesLoaded({required this.favorites, required this.favoriteIds});

  bool isFavorite(String itemId) => favoriteIds.contains(itemId);

  @override
  List<Object?> get props => [favorites, favoriteIds];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}
