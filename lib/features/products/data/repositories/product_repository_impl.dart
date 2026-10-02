import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../product_mock_data.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  List<Product> getProducts() {
    return ProductMockData.products;
  }

  @override
  Product? getProductById(String id) {
    return ProductMockData.findById(id);
  }

  @override
  List<Product> getFeaturedProducts() {
    return ProductMockData.products
        .where((product) => product.isFeatured)
        .toList();
  }

  @override
  List<Product> getNewArrivals() {
    return ProductMockData.products.where((product) => product.isNew).toList();
  }

  @override
  List<Product> getTrendingProducts() {
    return ProductMockData.products
        .where((product) => product.isTrending)
        .toList();
  }

  @override
  List<Product> searchProducts(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return const [];
    }

    return ProductMockData.products.where((product) {
      final searchableText = [
        product.name,
        product.subtitle,
        product.description,
        product.category,
        ...product.colors,
        ...product.styleTags,
      ].join(' ').toLowerCase();

      return searchableText.contains(normalizedQuery);
    }).toList();
  }
}
