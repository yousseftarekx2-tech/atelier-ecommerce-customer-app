import 'package:equatable/equatable.dart';

enum AppAppearance { system, light, dark }

enum AppLanguage { english, arabic }

class SettingsState extends Equatable {
  const SettingsState({
    this.appearance = AppAppearance.system,
    this.language = AppLanguage.english,
  });

  final AppAppearance appearance;
  final AppLanguage language;

  SettingsState copyWith({AppAppearance? appearance, AppLanguage? language}) {
    return SettingsState(
      appearance: appearance ?? this.appearance,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [appearance, language];
}
