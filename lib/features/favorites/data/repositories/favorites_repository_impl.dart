import '../../domain/repositories/favorites_repository.dart';
import '../datasource/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._remoteDataSource);

  final FavoritesRemoteDataSource _remoteDataSource;

  @override
  Future<Set<String>> getFavoriteProductIds() {
    return _remoteDataSource.getFavoriteProductIds();
  }

  @override
  Future<void> addFavorite(String productId) {
    return _remoteDataSource.addFavorite(productId);
  }

  @override
  Future<void> removeFavorite(String productId) {
    return _remoteDataSource.removeFavorite(productId);
  }
}
