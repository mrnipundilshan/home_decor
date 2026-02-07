import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/feature/home/domain/repository/item_repository.dart';
import 'package:home_decor/feature/home/domain/entity/favorite_entity.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ItemRepository itemRepository;

  FavoritesBloc({required this.itemRepository}) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final result = await itemRepository.getFavorites();
    result.fold(
      (failure) => emit(FavoritesError(message: "Failed to load favorites")),
      (favorites) {
        final favoriteIds = favorites.map((e) => e.itemId).toSet();
        emit(FavoritesLoaded(favorites: favorites, favoriteIds: favoriteIds));
      },
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is FavoritesLoaded) {
      final currentState = state as FavoritesLoaded;
      final isCurrentlyFavorite = currentState.favoriteIds.contains(
        event.itemId,
      );

      // Optimistic UI Update
      final newFavoriteIds = Set<String>.from(currentState.favoriteIds);
      if (isCurrentlyFavorite) {
        newFavoriteIds.remove(event.itemId);
      } else {
        newFavoriteIds.add(event.itemId);
      }

      // Emit optimistic state immediately
      emit(
        FavoritesLoaded(
          favorites: currentState
              .favorites, // We don't bother updating the full list for optimistic UI
          favoriteIds: newFavoriteIds,
        ),
      );

      if (isCurrentlyFavorite) {
        final result = await itemRepository.removeFavorite(event.itemId);
        result.fold(
          (failure) {
            // Revert on failure
            emit(currentState);
          },
          (_) {
            // Refresh in background if needed, or just stay as is
            // For now, we'll just keep the optimistic state
          },
        );
      } else {
        final result = await itemRepository.addFavorite(event.itemId);
        result.fold(
          (failure) {
            // Revert on failure
            emit(currentState);
          },
          (favorite) {
            // Update full list with the real entity from server
            final newFavorites = List<FavoriteEntity>.from(
              currentState.favorites,
            )..add(favorite);
            emit(
              FavoritesLoaded(
                favorites: newFavorites,
                favoriteIds: newFavoriteIds,
              ),
            );
          },
        );
      }
    }
  }
}
