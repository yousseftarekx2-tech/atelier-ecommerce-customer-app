import '../../../products/domain/entities/product.dart';
import '../entities/style_preferences.dart';

class PersonalizationService {
  const PersonalizationService();

  List<Product> rankProducts({
    required List<Product> products,
    required StylePreferences preferences,
  }) {
    if (preferences.isEmpty) {
      return List<Product>.from(products);
    }

    final scoredProducts = products.map((product) {
      return _ScoredProduct(
        product: product,
        score: _calculateScore(product: product, preferences: preferences),
      );
    }).toList();

    scoredProducts.sort((a, b) => b.score.compareTo(a.score));

    return scoredProducts.map((item) => item.product).toList();
  }

  int _calculateScore({
    required Product product,
    required StylePreferences preferences,
  }) {
    var score = 0;

    score += _matchCount(product.styleTags, preferences.styles) * 40;

    score += _matchCount(product.colorTags, preferences.colors) * 25;

    score += _matchCount(product.lifestyleTags, preferences.lifestyles) * 15;

    if (product.fit != null && preferences.fits.contains(product.fit)) {
      score += 20;
    }

    return score;
  }

  int _matchCount(List<String> productTags, Set<String> preferences) {
    return productTags.where(preferences.contains).length;
  }
}

class _ScoredProduct {
  const _ScoredProduct({required this.product, required this.score});

  final Product product;
  final int score;
}
