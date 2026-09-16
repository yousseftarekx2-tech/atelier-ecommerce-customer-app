class Product {
  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    required this.galleryImages,
    required this.category,
    required this.sizes,
    required this.colors,
    required this.stock,
    this.badge,
    this.compareAtPrice,
    this.rating,
    this.reviewCount,
    this.material,
    this.fit,
    this.styleTags = const [],
    this.careInstructions,
    this.deliveryInfo,
    this.isFeatured = false,
    this.isNew = false,
    this.isTrending = false,
  });

  final String id;
  final String name;
  final String subtitle;
  final String description;
  final int price;
  final String image;
  final List<String> galleryImages;
  final String category;
  final List<String> sizes;
  final List<String> colors;
  final int stock;

  final String? badge;
  final int? compareAtPrice;
  final double? rating;
  final int? reviewCount;
  final String? material;
  final String? fit;
  final List<String> styleTags;
  final String? careInstructions;
  final String? deliveryInfo;

  final bool isFeatured;
  final bool isNew;
  final bool isTrending;
}
