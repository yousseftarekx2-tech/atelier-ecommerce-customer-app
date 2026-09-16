import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit() : super(<String>{});

  bool isFavorite(String productId) {
    return state.contains(productId);
  }

  void toggle(String productId) {
    final updatedFavorites = {...state};

    if (updatedFavorites.contains(productId)) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    emit(updatedFavorites);
  }

  void remove(String productId) {
    if (!state.contains(productId)) {
      return;
    }

    final updatedFavorites = {...state}..remove(productId);

    emit(updatedFavorites);
  }

  void clear() {
    emit(<String>{});
  }
}
