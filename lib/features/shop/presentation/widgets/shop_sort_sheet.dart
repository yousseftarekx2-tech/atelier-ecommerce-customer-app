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
    (value: ShopSortOption.recommended, label: 'Recommended'),
    (value: ShopSortOption.priceLowToHigh, label: 'Price: Low to High'),
    (value: ShopSortOption.priceHighToLow, label: 'Price: High to Low'),
    (value: ShopSortOption.newest, label: 'Newest'),
    (value: ShopSortOption.nameAToZ, label: 'Name: A to Z'),
  ];

  @override
  Widget build(BuildContext context) {
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
            Text('Sort by', style: AppTextStyles.headingSmall),
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
                      value: option.value,
                      title: Text(
                        option.label,
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
