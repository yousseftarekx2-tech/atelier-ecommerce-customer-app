import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/domain/repositories/product_repository.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(this._productRepository)
    : super(ShopInitial(products: _productRepository.getProducts()));

  final ProductRepository _productRepository;

  void selectCategory(String category) {
    final products = _productRepository.getProducts();

    if (category == 'All') {
      emit(ShopUpdated(products: products, selectedCategory: category));
      return;
    }

    final filteredProducts = products
        .where(
          (product) => product.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();

    emit(ShopUpdated(products: filteredProducts, selectedCategory: category));
  }
}
