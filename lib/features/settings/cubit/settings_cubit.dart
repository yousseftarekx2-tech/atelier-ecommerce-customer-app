import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState());

  final SettingsRepository _repository;

  void loadSettings() {
    emit(
      SettingsState(
        appearance: _repository.getAppearance(),
        language: _repository.getLanguage(),
      ),
    );
  }

  Future<void> setAppearance(AppAppearance appearance) async {
    await _repository.saveAppearance(appearance);

    emit(state.copyWith(appearance: appearance));
  }

  Future<void> setLanguage(AppLanguage language) async {
    await _repository.saveLanguage(language);

    emit(state.copyWith(language: language));
  }
}
