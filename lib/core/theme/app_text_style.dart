import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.8,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Headings
  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // Button
  static const TextStyle button = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.2,
  );

  // Price
  static const TextStyle priceLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const TextStyle priceMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  // Arabic
  static const TextStyle arabicBody = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.7,
  );

  static const TextStyle arabicLabel = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.7,
  );
}
