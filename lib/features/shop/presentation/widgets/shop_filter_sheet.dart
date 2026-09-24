
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class ShopFilterSheet extends StatefulWidget {
  const ShopFilterSheet({
    required this.selectedMinPrice,
    required this.selectedMaxPrice,
    required this.onlyAvailable,
    required this.selectedSizes,
    super.key,
  });

  final double selectedMinPrice;
  final double selectedMaxPrice;
  final bool onlyAvailable;
  final List<String> selectedSizes;

  @override
  State<ShopFilterSheet> createState() => _ShopFilterSheetState();
}

class _ShopFilterSheetState extends State<ShopFilterSheet> {
  static const double minPrice = 0;
  static const double maxPrice = 10000;

  static const sizes = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
  ];

  late RangeValues _priceRange;
  late bool _onlyAvailable;
  late Set<String> _selectedSizes;

  @override
  void initState() {
    super.initState();

    _priceRange = RangeValues(
      widget.selectedMinPrice.clamp(minPrice, maxPrice),
      widget.selectedMaxPrice.clamp(minPrice, maxPrice),
    );

    _onlyAvailable = widget.onlyAvailable;
    _selectedSizes = widget.selectedSizes.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s20,
          AppSpacing.s8,
          AppSpacing.s20,
          AppSpacing.s20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s20),
            Text(
              'Filter',
              style: AppTextStyles.headingSmall.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.s24),
            Text(
              'Price',
              style: AppTextStyles.labelLarge.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.s8),
            RangeSlider(
              values: _priceRange,
              min: minPrice,
              max: maxPrice,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _priceRange = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_priceRange.start.round()} EGP',
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  '${_priceRange.end.round()} EGP',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s20),
            Text(
              'Size',
              style: AppTextStyles.labelLarge.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.s10),
            Wrap(
              spacing: AppSpacing.s8,
              runSpacing: AppSpacing.s8,
              children: sizes.map((size) {
                final selected = _selectedSizes.contains(size);

                return FilterChip(
                  label: Text(size),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        _selectedSizes.add(size);
                      } else {
                        _selectedSizes.remove(size);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.s12),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Available only',
                style: AppTextStyles.bodyMedium,
              ),
              value: _onlyAvailable,
              onChanged: (value) {
                setState(() {
                  _onlyAvailable = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.s16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    ShopFilterResult(
                      minPrice: _priceRange.start,
                      maxPrice: _priceRange.end,
                      onlyAvailable: _onlyAvailable,
                      selectedSizes: _selectedSizes.toList(),
                    ),
                  );
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopFilterResult {
  const ShopFilterResult({
    required this.minPrice,
    required this.maxPrice,
    required this.onlyAvailable,
    required this.selectedSizes,
  });

  final double minPrice;
  final double maxPrice;
  final bool onlyAvailable;
  final List<String> selectedSizes;
}
