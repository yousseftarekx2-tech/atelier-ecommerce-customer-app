import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/domain/repositories/product_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._productRepository) : super(const HomeInitial());

  final ProductRepository _productRepository;

  Timer? _searchDebounce;

  void loadHome() {
    emit(
      HomeLoading(
        pickedForYou: state.pickedForYou,
        trendingNow: state.trendingNow,
        newArrivals: state.newArrivals,
        searchQuery: state.searchQuery,
        searchResults: state.searchResults,
      ),
    );

    try {
      final pickedForYou = _productRepository.getFeaturedProducts();
      final trendingNow = _productRepository.getTrendingProducts();
      final newArrivals = _productRepository.getNewArrivals();

      emit(
        HomeLoaded(
          pickedForYou: pickedForYou,
          trendingNow: trendingNow,
          newArrivals: newArrivals,
          searchQuery: state.searchQuery,
          searchResults: state.searchResults,
        ),
      );
    } catch (error) {
      emit(
        HomeError(
          message: error.toString(),
          pickedForYou: state.pickedForYou,
          trendingNow: state.trendingNow,
          newArrivals: state.newArrivals,
          searchQuery: state.searchQuery,
          searchResults: state.searchResults,
        ),
      );
    }
  }

  void search(String query) {
    _searchDebounce?.cancel();

    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) {
      emit(
        HomeLoaded(
          pickedForYou: state.pickedForYou,
          trendingNow: state.trendingNow,
          newArrivals: state.newArrivals,
        ),
      );
      return;
    }

    emit(
      HomeLoaded(
        pickedForYou: state.pickedForYou,
        trendingNow: state.trendingNow,
        newArrivals: state.newArrivals,
        searchQuery: query,
        searchResults: state.searchResults,
      ),
    );

    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      final results = _productRepository.searchProducts(normalizedQuery);

      emit(
        HomeLoaded(
          pickedForYou: state.pickedForYou,
          trendingNow: state.trendingNow,
          newArrivals: state.newArrivals,
          searchQuery: query,
          searchResults: results,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
