import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/product.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  Future<List<Product>> getProducts() async {
    final rows = await _supabase
        .from('products')
        .select('''
          *,
          categories ( name ),
          product_images (
            id,
            image_url,
            sort_order,
            is_primary
          ),
          product_variants (
            id,
            size,
            color,
            stock,
            sku
          )
        ''')
        .eq('is_active', true)
        .order('created_at', ascending: false);

    return rows
        .map((row) => _mapProduct(Map<String, dynamic>.from(row)))
        .toList();
  }

  Product _mapProduct(Map<String, dynamic> row) {
    final categoryData = row['categories'];
    final category = categoryData is Map<String, dynamic>
        ? (categoryData['name'] as String? ?? '')
        : '';

    final imageRows = ((row['product_images'] as List?) ?? const [])
        .whereType<Map>()
        .map((image) => Map<String, dynamic>.from(image))
        .toList()
      ..sort((a, b) {
        final aOrder = (a['sort_order'] as num?)?.toInt() ?? 0;
        final bOrder = (b['sort_order'] as num?)?.toInt() ?? 0;
        return aOrder.compareTo(bOrder);
      });

    final variantRows = ((row['product_variants'] as List?) ?? const [])
        .whereType<Map>()
        .map((variant) => Map<String, dynamic>.from(variant))
        .toList();

    final galleryImages = imageRows
        .map((image) => image['image_url'] as String?)
        .whereType<String>()
        .where((url) => url.trim().isNotEmpty)
        .toList();

    final primaryImage = imageRows
        .where((image) => image['is_primary'] == true)
        .map((image) => image['image_url'] as String?)
        .whereType<String>()
        .where((url) => url.trim().isNotEmpty)
        .firstOrNull;

    final sizes = variantRows
        .map((variant) => variant['size'] as String?)
        .whereType<String>()
        .where((size) => size.trim().isNotEmpty)
        .toSet()
        .toList();

    final colors = variantRows
        .map((variant) => variant['color'] as String?)
        .whereType<String>()
        .where((color) => color.trim().isNotEmpty)
        .toSet()
        .toList();

    final stock = variantRows.fold<int>(
      0,
      (total, variant) => total + ((variant['stock'] as num?)?.toInt() ?? 0),
    );

    final styleTags = _stringList(row['style_tags']);
    final colorTags = _stringList(row['color_tags']);
    final lifestyleTags = _stringList(row['lifestyle_tags']);

    return Product(
      id: row['id'] as String,
      name: row['name'] as String? ?? '',
      subtitle: row['subtitle'] as String? ?? '',
      description: row['description'] as String? ?? '',
      price: (row['price'] as num?)?.toInt() ?? 0,
      image: primaryImage ?? galleryImages.firstOrNull ?? '',
      galleryImages: galleryImages,
      category: category,
      sizes: sizes,
      colors: colors,
      stock: stock,
      badge: row['badge'] as String?,
      compareAtPrice: (row['compare_at_price'] as num?)?.toInt(),
      rating: (row['rating'] as num?)?.toDouble(),
      reviewCount: (row['review_count'] as num?)?.toInt(),
      material: row['material'] as String?,
      fit: row['fit'] as String?,
      styleTags: styleTags,
      colorTags: colorTags,
      lifestyleTags: lifestyleTags,
      careInstructions: row['care_instructions'] as String?,
      deliveryInfo: row['delivery_info'] as String?,
      isFeatured: row['is_featured'] as bool? ?? false,
      isNew: row['is_new'] as bool? ?? false,
      isTrending: row['is_trending'] as bool? ?? false,
    );
  }

  List<String> _stringList(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return value.whereType<String>().where((item) => item.trim().isNotEmpty).toList();
  }
}
