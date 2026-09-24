import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class ShopSearchBar extends StatelessWidget {
  const ShopSearchBar({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      onChanged: onChanged,
      style: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: 'Search pieces',
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 21,
          color: colorScheme.onSurface.withValues(alpha: 0.65),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}
