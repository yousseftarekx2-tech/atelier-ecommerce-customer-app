import '../entities/product.dart';

abstract interface class ProductRepository {
  List<Product> getProducts();

  Product? getProductById(String id);

  List<Product> getFeaturedProducts();

  List<Product> getNewArrivals();

  List<Product> getTrendingProducts();

  List<Product> searchProducts(String query);
}
