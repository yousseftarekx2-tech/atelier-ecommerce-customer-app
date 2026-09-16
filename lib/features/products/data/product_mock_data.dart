import '../domain/entities/product.dart';

abstract final class ProductMockData {
  static const products = [
    Product(
      id: 'product_001',
      name: 'Utility Overshirt',
      subtitle: 'Slate Grey • Relaxed fit',
      description:
          'A relaxed utility overshirt designed for effortless everyday layering. Clean construction, functional details, and a versatile silhouette.',
      price: 1850,
      image: 'assets/images/home/picked_1.jpg',
      galleryImages: ['assets/images/home/picked_1.jpg'],
      category: 'Essentials',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Slate Grey'],
      stock: 18,
      badge: 'NEW',
      isFeatured: true,
      isNew: true,
    ),
    Product(
      id: 'product_002',
      name: 'Denim Jacket',
      subtitle: 'Washed Charcoal • Loose fit',
      description:
          'A relaxed denim jacket with a washed charcoal finish and an easy oversized silhouette.',
      price: 2200,
      image: 'assets/images/home/picked_2.jpg',
      galleryImages: ['assets/images/home/picked_2.jpg'],
      category: 'Street',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Washed Charcoal'],
      stock: 12,
      isFeatured: true,
    ),
    Product(
      id: 'product_003',
      name: 'Oversized T-Shirt',
      subtitle: 'Washed Bone • Boxy fit',
      description:
          'A clean oversized t-shirt with a boxy fit, designed as an everyday wardrobe essential.',
      price: 750,
      image: 'assets/images/home/picked_3.jpg',
      galleryImages: ['assets/images/home/picked_3.jpg'],
      category: 'Essentials',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Washed Bone', 'Slate Grey', 'Obsidian', 'Raw Sand'],
      stock: 30,
      compareAtPrice: 1040,
      rating: 4.8,
      reviewCount: 24,
      material: '100% premium cotton.',
      fit: 'Oversized drape',
      styleTags: ['Minimal', 'Modern', 'Everyday'],
      careInstructions:
          'Machine wash cold. Wash with similar colors. Do not bleach.',
      deliveryInfo:
          'Fast delivery with easy returns according to our return policy.',
      isFeatured: true,
    ),
    Product(
      id: 'product_004',
      name: 'Wide-Leg Pants',
      subtitle: 'Dark Umber • Pleated',
      description:
          'Relaxed wide-leg trousers with a pleated front and a refined everyday silhouette.',
      price: 1600,
      image: 'assets/images/home/trending_now_1.jpg',
      galleryImages: ['assets/images/home/trending_now_1.jpg'],
      category: 'Minimal',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Dark Umber'],
      stock: 16,
      isTrending: true,
    ),
    Product(
      id: 'product_005',
      name: 'Bomber Jacket',
      subtitle: 'Matte Black • Cropped',
      description:
          'A modern cropped bomber jacket with a matte black finish and a clean structured shape.',
      price: 1950,
      image: 'assets/images/home/trending_now_2.jpg',
      galleryImages: ['assets/images/home/trending_now_2.jpg'],
      category: 'Street',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Matte Black'],
      stock: 9,
      badge: 'SALE',
      isTrending: true,
    ),
    Product(
      id: 'product_006',
      name: 'Classic Cap',
      subtitle: 'Obsidian • 6-Panel',
      description:
          'A classic six-panel cap with a minimal ATELIER-inspired silhouette.',
      price: 550,
      image: 'assets/images/home/trending_now_3.jpg',
      galleryImages: ['assets/images/home/trending_now_3.jpg'],
      category: 'Everyday',
      sizes: ['OS'],
      colors: ['Obsidian'],
      stock: 25,
      isTrending: true,
    ),
    Product(
      id: 'product_007',
      name: 'Crewneck Sweatshirt',
      subtitle: 'Oatmeal Heather • Relaxed',
      description:
          'A relaxed crewneck sweatshirt built for everyday comfort with a clean elevated finish.',
      price: 1400,
      image: 'assets/images/home/new_arrivals_1.jpg',
      galleryImages: ['assets/images/home/new_arrivals_1.jpg'],
      category: 'Essentials',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Oatmeal Heather'],
      stock: 14,
      badge: 'NEW',
      isNew: true,
    ),
    Product(
      id: 'product_008',
      name: 'Flannel Shirt',
      subtitle: 'Muted Khaki • Oversized',
      description:
          'An oversized flannel shirt in a muted khaki palette for effortless layering.',
      price: 1650,
      image: 'assets/images/home/new_arrivals_2.jpg',
      galleryImages: ['assets/images/home/new_arrivals_2.jpg'],
      category: 'Everyday',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Muted Khaki'],
      stock: 11,
      isNew: true,
    ),
    Product(
      id: 'product_009',
      name: 'Cargo Pants',
      subtitle: 'Washed Olive • Relaxed',
      description:
          'Relaxed cargo pants with a washed olive finish and functional everyday pockets.',
      price: 1750,
      image: 'assets/images/home/new_arrivals_3.jpg',
      galleryImages: ['assets/images/home/new_arrivals_3.jpg'],
      category: 'Street',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Washed Olive'],
      stock: 13,
      isNew: true,
    ),
  ];

  static Product? findById(String id) {
    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }
}
