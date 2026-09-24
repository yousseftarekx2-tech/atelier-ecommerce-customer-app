import '../../cubit/settings_state.dart';

abstract class SettingsRepository {
  AppAppearance getAppearance();

  Future<void> saveAppearance(AppAppearance appearance);

  AppLanguage getLanguage();

  Future<void> saveLanguage(AppLanguage language);
}
