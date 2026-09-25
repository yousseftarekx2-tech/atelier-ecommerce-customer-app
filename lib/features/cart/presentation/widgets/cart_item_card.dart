import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_colors.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/data/product_mock_data.dart';
import '../../cubit/cart_cubit.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_quantity_control.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final product = ProductMockData.findById(item.productId);
    final colorScheme = Theme.of(context).colorScheme;

    if (product == null) {
      final l10n = AppLocalizations.of(context)!;

      return Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.r12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Text(
                l10n.cartProductUnavailable,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>().removeItem(item.key);
              },
              icon: Icon(
                Icons.close,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    final hasOldPrice =
        product.compareAtPrice != null &&
        product.compareAtPrice! > item.unitPrice;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(image: product.image, badge: product.badge),
          const SizedBox(width: AppSpacing.s14),
          Expanded(
            child: SizedBox(
              height: 105,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductHeader(
                    name: product.name,
                    onRemove: () {
                      context.read<CartCubit>().removeItem(item.key);
                    },
                  ),
                  const SizedBox(height: AppSpacing.s6),
                  _VariantInfo(color: item.color, size: item.size),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _PriceInfo(
                          price: item.unitPrice,
                          oldPrice: hasOldPrice ? product.compareAtPrice : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s8),
                      CartQuantityControl(
                        quantity: item.quantity,
                        onDecrease: () {
                          context.read<CartCubit>().decrement(item.key);
                        },
                        onIncrease: () {
                          context.read<CartCubit>().increment(item.key);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.image, required this.badge});

  final String image;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.r9),
          child: Container(
            width: 84,
            height: 105,
            color: colorScheme.surfaceContainerHighest,
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  )
                : Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
          ),
        ),
        if (badge != null && badge!.isNotEmpty)
          Positioned(
            top: AppSpacing.s6,
            left: AppSpacing.s6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s6,
                vertical: AppSpacing.s3,
              ),
              decoration: BoxDecoration(
                color: badge!.toUpperCase() == 'SALE'
                    ? AppColors.error
                    : AppColors.black,
                borderRadius: BorderRadius.circular(AppRadius.r4),
              ),
              child: Text(
                badge!.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({required this.name, required this.onRemove});

  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelLarge.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s6),
        GestureDetector(
          onTap: onRemove,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 28,
            height: 28,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Icon(
                Icons.close,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _VariantInfo extends StatelessWidget {
  const _VariantInfo({required this.color, required this.size});

  final String color;
  final String size;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            color: _colorFromName(color),
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.outlineVariant),
          ),
        ),
        const SizedBox(width: AppSpacing.s6),
        Flexible(
          child: Text(
            color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s6,
            vertical: AppSpacing.s4,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.r4),
          ),
          child: Text(
            l10n.cartSize(size),
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Color _colorFromName(String value) {
    final normalized = value.toLowerCase();

    if (normalized.contains('black') ||
        normalized.contains('obsidian') ||
        normalized.contains('charcoal')) {
      return const Color(0xFF252525);
    }

    if (normalized.contains('grey') || normalized.contains('gray')) {
      return const Color(0xFF737373);
    }

    if (normalized.contains('olive')) {
      return const Color(0xFF74765B);
    }

    if (normalized.contains('khaki')) {
      return const Color(0xFFA39A7A);
    }

    if (normalized.contains('bone') ||
        normalized.contains('oatmeal') ||
        normalized.contains('sand')) {
      return const Color(0xFFD8D0C0);
    }

    if (normalized.contains('umber')) {
      return const Color(0xFF5B4435);
    }

    return const Color(0xFFB7B3AC);
  }
}

class _PriceInfo extends StatelessWidget {
  const _PriceInfo({required this.price, required this.oldPrice});

  final int price;
  final int? oldPrice;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'EGP ${_formatPrice(price)}',
          style: AppTextStyles.priceMedium.copyWith(
            color: colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (oldPrice != null) ...[
          const SizedBox(height: AppSpacing.s2),
          Text(
            'EGP ${_formatPrice(oldPrice!)}',
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 10,
              decoration: TextDecoration.lineThrough,
              decorationColor: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  String _formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
