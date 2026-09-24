import 'package:shared_preferences/shared_preferences.dart';

class RecentlyViewedLocalDataSource {
  RecentlyViewedLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _key = 'recently_viewed_product_ids';
  static const int _maxItems = 20;

  List<String> getRecentlyViewedIds() {
    return _prefs.getStringList(_key) ?? const [];
  }

  Future<void> addProduct(String productId) async {
    final ids = [...getRecentlyViewedIds()];

    ids.remove(productId);
    ids.insert(0, productId);

    if (ids.length > _maxItems) {
      ids.removeRange(_maxItems, ids.length);
    }

    await _prefs.setStringList(_key, ids);
  }

  Future<void> clear() async {
    await _prefs.remove(_key);
  }
}
