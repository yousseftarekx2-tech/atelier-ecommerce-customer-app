import '../../domain/repositories/recently_viewed_repository.dart';
import '../datasource/recently_viewed_local_data_source.dart';

class RecentlyViewedRepositoryImpl implements RecentlyViewedRepository {
  RecentlyViewedRepositoryImpl(this._localDataSource);

  final RecentlyViewedLocalDataSource _localDataSource;

  @override
  Future<List<String>> getRecentlyViewedIds() async {
    return _localDataSource.getRecentlyViewedIds();
  }

  @override
  Future<void> addProduct(String productId) async {
    await _localDataSource.addProduct(productId);
  }

  @override
  Future<void> clear() async {
    await _localDataSource.clear();
  }
}
