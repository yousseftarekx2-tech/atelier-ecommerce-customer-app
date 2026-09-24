import '../entities/style_preferences.dart';

abstract class StyleRepository {
  Future<StylePreferences> getStylePreferences();

  Future<void> saveStylePreferences(StylePreferences preferences);

  Future<void> deleteStylePreferences();
}
