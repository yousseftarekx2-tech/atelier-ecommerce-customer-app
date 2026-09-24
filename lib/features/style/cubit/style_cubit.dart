import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/style_preferences.dart';
import '../domain/repositories/style_repository.dart';

class StyleCubit extends Cubit<StylePreferences> {
  StyleCubit(this._repository) : super(const StylePreferences());

  final StyleRepository _repository;

  Future<void> loadPreferences() async {
    try {
      final preferences = await _repository.getStylePreferences();

      emit(preferences);
    } catch (_) {
      emit(const StylePreferences());
    }
  }

  void toggleStyle(String value) {
    emit(state.copyWith(styles: _toggle(state.styles, value)));
  }

  void toggleColor(String value) {
    emit(state.copyWith(colors: _toggle(state.colors, value)));
  }

  void toggleLifestyle(String value) {
    emit(state.copyWith(lifestyles: _toggle(state.lifestyles, value)));
  }

  void toggleFit(String value) {
    emit(state.copyWith(fits: _toggle(state.fits, value)));
  }

  Future<void> savePreferences() async {
    await _repository.saveStylePreferences(state);
  }

  Future<void> reset() async {
    await _repository.deleteStylePreferences();

    emit(const StylePreferences());
  }

  Set<String> _toggle(Set<String> current, String value) {
    final updated = {...current};

    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }

    return updated;
  }
}
