abstract class RecentlyViewedRepository {
  Future<List<String>> getRecentlyViewedIds();

  Future<void> addProduct(String productId);

  Future<void> clear();
}