import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../products/domain/entities/product.dart';
import 'shop_product_card.dart';

class ShopProductGrid extends StatelessWidget {
  const ShopProductGrid({required this.products, this.onProductTap, super.key});

  final List<Product> products;
  final ValueChanged<Product>? onProductTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - AppSpacing.s16) / 2;
        final itemHeight = (itemWidth * 1.25) + 78;

        return GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.s16,
            mainAxisSpacing: AppSpacing.s28,
            mainAxisExtent: itemHeight,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return ShopProductCard(
              product: product,
              onTap: onProductTap == null ? null : () => onProductTap!(product),
            );
          },
        );
      },
    );
  }
}
