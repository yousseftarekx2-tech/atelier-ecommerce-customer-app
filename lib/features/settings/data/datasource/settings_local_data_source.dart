import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/settings_state.dart';

class SettingsLocalDataSource {
  SettingsLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const String _appearanceKey = 'settings_appearance';
  static const String _languageKey = 'settings_language';

  AppAppearance getAppearance() {
    final value = _prefs.getString(_appearanceKey);

    return AppAppearance.values.firstWhere(
      (appearance) => appearance.name == value,
      orElse: () => AppAppearance.system,
    );
  }

  Future<void> saveAppearance(AppAppearance appearance) async {
    await _prefs.setString(_appearanceKey, appearance.name);
  }

  AppLanguage getLanguage() {
    final value = _prefs.getString(_languageKey);

    return AppLanguage.values.firstWhere(
      (language) => language.name == value,
      orElse: () => AppLanguage.english,
    );
  }

  Future<void> saveLanguage(AppLanguage language) async {
    await _prefs.setString(_languageKey, language.name);
  }
}
