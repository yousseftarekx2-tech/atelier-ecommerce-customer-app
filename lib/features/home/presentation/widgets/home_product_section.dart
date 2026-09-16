import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../products/domain/entities/product.dart';
import 'home_product_card.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    required this.products,
    this.eyebrow,
    this.title,
    this.description,
    this.showViewAll = false,
    this.onProductTap,
    this.onViewAllTap,
    super.key,
  });

  final List<Product> products;
  final String? eyebrow;
  final String? title;
  final String? description;
  final bool showViewAll;
  final ValueChanged<Product>? onProductTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null) Text(eyebrow!, style: AppTextStyles.labelSmall),
        if (eyebrow != null) const SizedBox(height: AppSpacing.s6),
        if (title != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(title!, style: AppTextStyles.headingMedium)),
              if (showViewAll)
                TextButton(
                  onPressed: onViewAllTap,
                  child: const Text('View All'),
                ),
            ],
          ),
        if (description != null) ...[
          const SizedBox(height: AppSpacing.s6),
          Text(description!, style: AppTextStyles.bodyMedium),
        ],
        const SizedBox(height: AppSpacing.s16),
        SizedBox(
          height: 390,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s16),
            itemBuilder: (context, index) {
              final product = products[index];

              return HomeProductCard(
                product: product,
                onTap: onProductTap == null
                    ? null
                    : () => onProductTap!(product),
              );
            },
          ),
        ),
      ],
    );
  }
}
