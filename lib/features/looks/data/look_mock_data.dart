import '../../products/domain/entities/product.dart';
import '../../products/domain/repositories/product_repository.dart';
import '../domain/entities/look.dart';

abstract final class LookMockData {
  static List<Look> getLooks(ProductRepository repository) {
    return [
      Look(
        id: 'light-after-dark',
        title: 'LIGHT AFTER DARK',
        eyebrow: 'LOOK 01',
        tag: 'MINIMAL',
        description:
            'A clean layered uniform built for late city hours and gallery openings.',
        heroImage: 'assets/images/home/picked_3.jpg',
        products: _resolveProducts(repository, [
          'product_003',
          'product_016',
          'product_006',
          'product_005',
        ]),
      ),
      Look(
        id: 'city-static',
        title: 'CITY STATIC',
        eyebrow: 'LOOK 02',
        tag: 'STREET',
        description:
            'Clean structure with a decisive street tailoring edge and technical outerwear.',
        heroImage: 'assets/images/home/trending_now_2.jpg',
        products: _resolveProducts(repository, [
          'product_010',
          'product_014',
          'product_022',
          'product_005',
        ]),
      ),
      Look(
        id: 'off-duty',
        title: 'OFF DUTY',
        eyebrow: 'LOOK 03',
        tag: 'CASUAL',
        description:
            'Relaxed silhouette pieces constructed for everyday unscripted movement.',
        heroImage: 'assets/images/home/new_arrivals_1.jpg',
        products: _resolveProducts(repository, [
          'product_007',
          'product_014',
          'product_023',
        ]),
      ),
      Look(
        id: 'after-hours',
        title: 'AFTER HOURS',
        eyebrow: 'LOOK 04',
        tag: 'BOLD',
        description:
            'Sharper tonal silhouettes tailored for dusk onwards and refined nightlife.',
        heroImage: 'assets/images/home/trending_now_2.jpg',
        products: _resolveProducts(repository, [
          'product_003',
          'product_018',
          'product_005',
          'product_024',
        ]),
      ),
    ];
  }

  static Look? findById(ProductRepository repository, String id) {
    for (final look in getLooks(repository)) {
      if (look.id == id) {
        return look;
      }
    }

    return null;
  }

  static List<Product> _resolveProducts(
    ProductRepository repository,
    List<String> productIds,
  ) {
    return productIds
        .map(repository.getProductById)
        .whereType<Product>()
        .toList();
  }
}
