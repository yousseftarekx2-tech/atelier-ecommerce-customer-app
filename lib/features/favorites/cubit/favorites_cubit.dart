import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesInitial());

  bool isFavorite(String productId) {
    return state.productIds.contains(productId);
  }

  void toggle(String productId) {
    final updatedFavorites = {...state.productIds};

    if (updatedFavorites.contains(productId)) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    emit(FavoritesUpdated(updatedFavorites));
  }

  void remove(String productId) {
    if (!state.productIds.contains(productId)) {
      return;
    }

    final updatedFavorites = {...state.productIds}..remove(productId);

    emit(FavoritesUpdated(updatedFavorites));
  }

  void clear() {
    emit(const FavoritesUpdated({}));
  }
}
