import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/data/repositories/product_repository_impl.dart';
import '../../products/domain/entities/product.dart';
import '../../products/domain/repositories/product_repository.dart';
import '../presentation/widgets/shop_filter_sheet.dart';
import '../presentation/widgets/shop_sort_sheet.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit()
    : _repository = ProductRepositoryImpl(),
      super(const ShopInitial()) {
    loadProducts();
  }

  final ProductRepository _repository;

  late final List<Product> _allProducts;

  static const double minPrice = 0;
  static const double maxPrice = 10000;

  void loadProducts() {
    try {
      _allProducts = _repository.getProducts();

      emit(
        ShopLoaded(
          products: _allProducts,
          selectedCategory: 'All',
          selectedMinPrice: minPrice,
          selectedMaxPrice: maxPrice,
        ),
      );
    } catch (error) {
      emit(ShopError(error.toString()));
    }
  }

  void selectCategory(String category) {
    final currentState = state;

    if (currentState is! ShopLoaded) {
      return;
    }

    emit(
      _buildLoadedState(
        category: category,
        searchQuery: currentState.searchQuery,
        selectedMinPrice: currentState.selectedMinPrice,
        selectedMaxPrice: currentState.selectedMaxPrice,
        onlyAvailable: currentState.onlyAvailable,
        selectedSizes: currentState.selectedSizes,
        sortOption: currentState.sortOption,
      ),
    );
  }

  void search(String query) {
    final currentState = state;

    if (currentState is! ShopLoaded) {
      return;
    }

    emit(
      _buildLoadedState(
        category: currentState.selectedCategory,
        searchQuery: query,
        selectedMinPrice: currentState.selectedMinPrice,
        selectedMaxPrice: currentState.selectedMaxPrice,
        onlyAvailable: currentState.onlyAvailable,
        selectedSizes: currentState.selectedSizes,
        sortOption: currentState.sortOption,
      ),
    );
  }

  void applyFilters(ShopFilterResult result) {
    final currentState = state;

    if (currentState is! ShopLoaded) {
      return;
    }

    emit(
      _buildLoadedState(
        category: currentState.selectedCategory,
        searchQuery: currentState.searchQuery,
        selectedMinPrice: result.minPrice,
        selectedMaxPrice: result.maxPrice,
        onlyAvailable: result.onlyAvailable,
        selectedSizes: result.selectedSizes,
        sortOption: currentState.sortOption,
      ),
    );
  }

  void applySort(ShopSortOption option) {
    final currentState = state;

    if (currentState is! ShopLoaded) {
      return;
    }

    emit(
      _buildLoadedState(
        category: currentState.selectedCategory,
        searchQuery: currentState.searchQuery,
        selectedMinPrice: currentState.selectedMinPrice,
        selectedMaxPrice: currentState.selectedMaxPrice,
        onlyAvailable: currentState.onlyAvailable,
        selectedSizes: currentState.selectedSizes,
        sortOption: option,
      ),
    );
  }

  ShopLoaded _buildLoadedState({
    required String category,
    required String searchQuery,
    required double selectedMinPrice,
    required double selectedMaxPrice,
    required bool onlyAvailable,
    required List<String> selectedSizes,
    required ShopSortOption sortOption,
  }) {
    final normalizedQuery = searchQuery.trim().toLowerCase();

    var products = _allProducts.where((product) {
      final matchesCategory = category == 'All' || product.category == category;

      final matchesPrice =
          product.price >= selectedMinPrice &&
          product.price <= selectedMaxPrice;

      final matchesAvailability = !onlyAvailable || product.stock > 0;

      final matchesSize =
          selectedSizes.isEmpty || product.sizes.any(selectedSizes.contains);

      final searchableText = [
        product.name,
        product.subtitle,
        product.description,
        product.category,
        ...product.colors,
        ...product.styleTags,
      ].join(' ').toLowerCase();

      final matchesSearch =
          normalizedQuery.isEmpty || searchableText.contains(normalizedQuery);

      return matchesCategory &&
          matchesPrice &&
          matchesAvailability &&
          matchesSize &&
          matchesSearch;
    }).toList();

    switch (sortOption) {
      case ShopSortOption.recommended:
        break;
      case ShopSortOption.priceLowToHigh:
        products.sort((a, b) => a.price.compareTo(b.price));
      case ShopSortOption.priceHighToLow:
        products.sort((a, b) => b.price.compareTo(a.price));
      case ShopSortOption.newest:
        products.sort(
          (a, b) => b.isNew.toString().compareTo(a.isNew.toString()),
        );
      case ShopSortOption.nameAToZ:
        products.sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
    }

    return ShopLoaded(
      products: products,
      selectedCategory: category,
      searchQuery: searchQuery,
      selectedMinPrice: selectedMinPrice,
      selectedMaxPrice: selectedMaxPrice,
      onlyAvailable: onlyAvailable,
      selectedSizes: selectedSizes,
      sortOption: sortOption,
    );
  }
}
