import '../../cubit/settings_state.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasource/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._localDataSource);

  final SettingsLocalDataSource _localDataSource;

  @override
  AppAppearance getAppearance() {
    return _localDataSource.getAppearance();
  }

  @override
  Future<void> saveAppearance(AppAppearance appearance) {
    return _localDataSource.saveAppearance(appearance);
  }

  @override
  AppLanguage getLanguage() {
    return _localDataSource.getLanguage();
  }

  @override
  Future<void> saveLanguage(AppLanguage language) {
    return _localDataSource.saveLanguage(language);
  }
}
