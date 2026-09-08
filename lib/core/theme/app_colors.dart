import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const Color black = Color(0xFF111111);
  static const Color white = Color(0xFFFFFFFF);

  // Light Theme
  static const Color lightBackground = Color(0xFFF8F8F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceMuted = Color(0xFFF1F1EE);

  static const Color lightTextPrimary = Color(0xFF111111);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightTextMuted = Color(0xFF999999);

  static const Color lightBorder = Color(0xFFE2E2DE);
  static const Color lightDivider = Color(0xFFEAEAE6);

  // Dark Theme
  static const Color darkBackground = Color(0xFF111111);
  static const Color darkSurface = Color(0xFF181818);
  static const Color darkSurfaceMuted = Color(0xFF222222);

  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB5B5B5);
  static const Color darkTextMuted = Color(0xFF777777);

  static const Color darkBorder = Color(0xFF303030);
  static const Color darkDivider = Color(0xFF292929);

  // Status
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFB26A00);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF315B8C);

  // Overlay
  static const Color overlay = Color(0x66000000);
}
