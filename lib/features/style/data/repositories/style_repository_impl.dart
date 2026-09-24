import 'package:atelier_customer/features/style/data/datasource/style_remote_data_source.dart';

import '../../domain/entities/style_preferences.dart';
import '../../domain/repositories/style_repository.dart';

class StyleRepositoryImpl implements StyleRepository {
  StyleRepositoryImpl(this._remoteDataSource);

  final StyleRemoteDataSource _remoteDataSource;

  @override
  Future<StylePreferences> getStylePreferences() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return const StylePreferences();
    }

    final data = await _remoteDataSource.getStylePreferences(
      user.id,
    );

    if (data == null) {
      return const StylePreferences();
    }

    return StylePreferences(
      styles: Set<String>.from(
        data['styles'] ?? const [],
      ),
      colors: Set<String>.from(
        data['colors'] ?? const [],
      ),
      lifestyles: Set<String>.from(
        data['lifestyles'] ?? const [],
      ),
      fits: Set<String>.from(
        data['fits'] ?? const [],
      ),
    );
  }

  @override
  Future<void> saveStylePreferences(
    StylePreferences preferences,
  ) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.saveStylePreferences(
      userId: user.id,
      styles: preferences.styles.toList(),
      colors: preferences.colors.toList(),
      lifestyles: preferences.lifestyles.toList(),
      fits: preferences.fits.toList(),
    );
  }

  @override
  Future<void> deleteStylePreferences() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.deleteStylePreferences(user.id);
  }
}