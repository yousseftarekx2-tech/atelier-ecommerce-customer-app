import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._repository) : super(const FavoritesInitial());

  final FavoritesRepository _repository;

  final Set<String> _pendingProductIds = {};

  bool isFavorite(String productId) {
    return state.productIds.contains(productId);
  }

  Future<void> loadFavorites() async {
    try {
      emit(FavoritesUpdated(state.productIds, isLoading: true));

      final favoriteProductIds = await _repository.getFavoriteProductIds();

      if (isClosed) {
        return;
      }

      emit(FavoritesUpdated(favoriteProductIds));
    } catch (error) {
      if (isClosed) {
        return;
      }

      emit(FavoritesUpdated(state.productIds, errorMessage: error.toString()));
    }
  }

  Future<void> toggle(String productId) async {
    if (_pendingProductIds.contains(productId)) {
      return;
    }

    final wasFavorite = state.productIds.contains(productId);
    final updatedFavorites = {...state.productIds};

    if (wasFavorite) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    _pendingProductIds.add(productId);

    emit(FavoritesUpdated(updatedFavorites));

    try {
      if (wasFavorite) {
        await _repository.removeFavorite(productId);
      } else {
        await _repository.addFavorite(productId);
      }
    } catch (error) {
      if (isClosed) {
        return;
      }

      final rollbackFavorites = {...state.productIds};

      if (wasFavorite) {
        rollbackFavorites.add(productId);
      } else {
        rollbackFavorites.remove(productId);
      }

      emit(FavoritesUpdated(rollbackFavorites, errorMessage: error.toString()));
    } finally {
      _pendingProductIds.remove(productId);
    }
  }

  Future<void> remove(String productId) async {
    if (!state.productIds.contains(productId) ||
        _pendingProductIds.contains(productId)) {
      return;
    }

    final updatedFavorites = {...state.productIds}..remove(productId);

    _pendingProductIds.add(productId);

    emit(FavoritesUpdated(updatedFavorites));

    try {
      await _repository.removeFavorite(productId);
    } catch (error) {
      if (isClosed) {
        return;
      }

      final rollbackFavorites = {...state.productIds}..add(productId);

      emit(FavoritesUpdated(rollbackFavorites, errorMessage: error.toString()));
    } finally {
      _pendingProductIds.remove(productId);
    }
  }

  void clear() {
    _pendingProductIds.clear();
    emit(const FavoritesUpdated({}));
  }
}
