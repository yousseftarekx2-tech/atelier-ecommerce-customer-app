import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class ShopCategoryChips extends StatelessWidget {
  const ShopCategoryChips({
    required this.selectedCategory,
    required this.onCategorySelected,
    super.key,
  });

  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const categories = [
    'All',
    'Tops',
    'Bottoms',
    'Outerwear',
    'Accessories',
  ];

  String _localizedCategory(BuildContext context, String category) {
    final l10n = AppLocalizations.of(context)!;

    switch (category) {
      case 'All':
        return l10n.shopAll;
      case 'Tops':
        return l10n.shopTops;
      case 'Bottoms':
        return l10n.shopBottoms;
      case 'Outerwear':
        return l10n.shopOuterwear;
      case 'Accessories':
        return l10n.shopAccessories;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) {
          return const SizedBox(width: AppSpacing.s8);
        },
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Material(
            color: isSelected ? colorScheme.onSurface : colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: InkWell(
              onTap: () => onCategorySelected(category),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  _localizedCategory(context, category),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isSelected
                        ? colorScheme.surface
                        : colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
