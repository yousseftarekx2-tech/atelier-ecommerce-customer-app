import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

enum ShopSortOption {
  recommended,
  priceLowToHigh,
  priceHighToLow,
  newest,
  nameAToZ,
}

class ShopSortSheet extends StatelessWidget {
  const ShopSortSheet({required this.selectedOption, super.key});

  final ShopSortOption selectedOption;

  static const options = [
    ShopSortOption.recommended,
    ShopSortOption.priceLowToHigh,
    ShopSortOption.priceHighToLow,
    ShopSortOption.newest,
    ShopSortOption.nameAToZ,
  ];

  String _localizedLabel(BuildContext context, ShopSortOption option) {
    final l10n = AppLocalizations.of(context)!;

    switch (option) {
      case ShopSortOption.recommended:
        return l10n.shopSortRecommended;
      case ShopSortOption.priceLowToHigh:
        return l10n.shopSortPriceLowToHigh;
      case ShopSortOption.priceHighToLow:
        return l10n.shopSortPriceHighToLow;
      case ShopSortOption.newest:
        return l10n.shopSortNewest;
      case ShopSortOption.nameAToZ:
        return l10n.shopSortNameAToZ;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s20,
          AppSpacing.s12,
          AppSpacing.s20,
          AppSpacing.s20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.shopSortProducts, style: AppTextStyles.headingSmall),
            const SizedBox(height: AppSpacing.s12),
            RadioGroup<ShopSortOption>(
              groupValue: selectedOption,
              onChanged: (value) {
                if (value != null) {
                  Navigator.pop(context, value);
                }
              },
              child: Column(
                children: [
                  ...options.map((option) {
                    return RadioListTile<ShopSortOption>(
                      contentPadding: EdgeInsets.zero,
                      value: option,
                      title: Text(
                        _localizedLabel(context, option),
                        style: AppTextStyles.bodyMedium,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
