import 'dart:async';

import 'package:atelier_customer/features/style/domain/service/personalization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/domain/entities/product.dart';
import '../../products/domain/repositories/product_repository.dart';
import '../../style/domain/entities/style_preferences.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._productRepository, {
    PersonalizationService? personalizationService,
  }) : _personalizationService =
          personalizationService ?? const PersonalizationService(),
      super(const HomeInitial());

  final ProductRepository _productRepository;
  final PersonalizationService _personalizationService;

  Timer? _searchDebounce;

  StylePreferences _stylePreferences = const StylePreferences();

  List<Product> _featuredProducts = const [];

  void updateStylePreferences(StylePreferences preferences) {
    _stylePreferences = preferences;

    if (_featuredProducts.isEmpty) {
      return;
    }

    final personalizedProducts = _personalizationService.rankProducts(
      products: _featuredProducts,
      preferences: _stylePreferences,
    );

    emit(
      HomeLoaded(
        pickedForYou: personalizedProducts,
        trendingNow: state.trendingNow,
        newArrivals: state.newArrivals,
        searchQuery: state.searchQuery,
        searchResults: state.searchResults,
      ),
    );
  }

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
      final featuredProducts = _productRepository.getFeaturedProducts();

      _featuredProducts = featuredProducts;

      final pickedForYou = _personalizationService.rankProducts(
        products: _featuredProducts,
        preferences: _stylePreferences,
      );

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
