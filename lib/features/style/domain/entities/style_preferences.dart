class StylePreferences {
  const StylePreferences({
    this.styles = const {},
    this.colors = const {},
    this.lifestyles = const {},
    this.fits = const {},
  });

  final Set<String> styles;
  final Set<String> colors;
  final Set<String> lifestyles;
  final Set<String> fits;

  int get selectedCount {
    return styles.length + colors.length + lifestyles.length + fits.length;
  }

  bool get isEmpty {
    return styles.isEmpty &&
        colors.isEmpty &&
        lifestyles.isEmpty &&
        fits.isEmpty;
  }

  StylePreferences copyWith({
    Set<String>? styles,
    Set<String>? colors,
    Set<String>? lifestyles,
    Set<String>? fits,
  }) {
    return StylePreferences(
      styles: styles ?? this.styles,
      colors: colors ?? this.colors,
      lifestyles: lifestyles ?? this.lifestyles,
      fits: fits ?? this.fits,
    );
  }
}
