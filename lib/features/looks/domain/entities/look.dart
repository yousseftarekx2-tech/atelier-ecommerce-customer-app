import 'package:atelier_customer/features/products/domain/entities/product.dart';

class Look {
  const Look({
    required this.id,
    required this.title,
    required this.eyebrow,
    required this.tag,
    required this.description,
    required this.heroImage,
    required this.products,
  });

  final String id;
  final String title;
  final String eyebrow;
  final String tag;
  final String description;
  final String heroImage;
  final List<Product> products;

  List<Product> get availableProducts {
    return products.where((product) => product.stock > 0).toList();
  }

  int get availableProductCount {
    return availableProducts.length;
  }

  int get totalPrice {
    return availableProducts.fold(0, (total, product) => total + product.price);
  }
}
