import 'package:equatable/equatable.dart';

import '../../products/domain/entities/product.dart';

sealed class ShopState extends Equatable {
  const ShopState({required this.products, required this.selectedCategory});

  final List<Product> products;
  final String selectedCategory;

  @override
  List<Object?> get props => [products, selectedCategory];
}

final class ShopInitial extends ShopState {
  const ShopInitial({required super.products, super.selectedCategory = 'All'});
}

final class ShopUpdated extends ShopState {
  const ShopUpdated({required super.products, super.selectedCategory = 'All'});
}
