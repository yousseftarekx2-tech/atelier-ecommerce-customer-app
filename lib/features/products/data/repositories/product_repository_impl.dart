import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  List<Product> _products = const [];
  Future<void>? _loadFuture;
  Object? _loadError;

  @override
  // ignore: override_on_non_overriding_member
  Future<void> loadProducts() {
    final existingLoad = _loadFuture;

    if (existingLoad != null) {
      return existingLoad;
    }

    final future = _loadProducts();
    _loadFuture = future;
    return future;
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _remoteDataSource.getProducts();

      _products = List.unmodifiable(products);
      _loadError = null;
    } catch (error) {
      _loadError = error;
      rethrow;
    } finally {
      _loadFuture = null;
    }
  }

  @override
  List<Product> getProducts() {
    _throwIfLoadFailed();
    return _products;
  }

  @override
  Product? getProductById(String id) {
    _throwIfLoadFailed();

    for (final product in _products) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }

  @override
  List<Product> getFeaturedProducts() {
    return _filter((product) => product.isFeatured);
  }

  @override
  List<Product> getNewArrivals() {
    return _filter((product) => product.isNew);
  }

  @override
  List<Product> getTrendingProducts() {
    return _filter((product) => product.isTrending);
  }

  @override
  List<Product> searchProducts(String query) {
    _throwIfLoadFailed();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return const [];
    }

    return _products.where((product) {
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

  List<Product> _filter(bool Function(Product product) predicate) {
    _throwIfLoadFailed();
    return _products.where(predicate).toList();
  }

  void _throwIfLoadFailed() {
    final error = _loadError;

    if (error != null) {
      throw StateError('Unable to load products: $error');
    }
  }
}
