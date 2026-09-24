import 'package:atelier_customer/features/products/domain/entities/product.dart';

import '../presentation/widgets/shop_sort_sheet.dart';

sealed class ShopState {
  const ShopState();
}

final class ShopInitial extends ShopState {
  const ShopInitial();
}

final class ShopLoaded extends ShopState {
  const ShopLoaded({
    required this.products,
    required this.selectedCategory,
    this.searchQuery = '',
    this.selectedMinPrice = 0,
    this.selectedMaxPrice = 10000,
    this.onlyAvailable = false,
    this.selectedSizes = const [],
    this.sortOption = ShopSortOption.recommended,
  });

  final List<Product> products;
  final String selectedCategory;
  final String searchQuery;
  final double selectedMinPrice;
  final double selectedMaxPrice;
  final bool onlyAvailable;
  final List<String> selectedSizes;
  final ShopSortOption sortOption;
}

final class ShopError extends ShopState {
  const ShopError(this.message);

  final String message;
}
