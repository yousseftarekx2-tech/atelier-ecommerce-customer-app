import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../favorites/cubit/favorites_cubit.dart';
import '../../../products/domain/entities/product.dart';

class FavoritesProductCard extends StatelessWidget {
  const FavoritesProductCard({
    required this.product,
    this.onTap,
    this.onQuickAdd,
    super.key,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onQuickAdd;

  bool get _isNetworkImage {
    return product.image.startsWith('http://') ||
        product.image.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _isNetworkImage
                      ? Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) {
                            return Container(
                              color: colorScheme.surfaceContainerHighest,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            );
                          },
                        )
                      : Image.asset(product.image, fit: BoxFit.cover),
                  if (product.badge != null)
                    Positioned(
                      top: AppSpacing.s10,
                      left: AppSpacing.s10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s8,
                          vertical: AppSpacing.s6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(AppRadius.r4),
                        ),
                        child: Text(
                          product.badge!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: AppSpacing.s6,
                    right: AppSpacing.s6,
                    child: Material(
                      color: colorScheme.surface.withValues(alpha: 0.92),
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          context.read<FavoritesCubit>().remove(product.id);
                        },
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(AppSpacing.s9),
                          child: Icon(Icons.favorite, size: 18),
                        ),
                      ),
                    ),
                  ),
                  if (product.stock > 0)
                    Positioned(
                      right: AppSpacing.s8,
                      bottom: AppSpacing.s8,
                      child: Material(
                        color: colorScheme.surface.withValues(alpha: 0.92),
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: onQuickAdd,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(AppSpacing.s9),
                            child: Icon(Icons.add, size: 18),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s10),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelLarge.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          Text(
            product.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.58),
            ),
          ),
          const SizedBox(height: AppSpacing.s6),
          Row(
            children: [
              Text(
                '${product.price} EGP',
                style: AppTextStyles.priceMedium.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              if (product.compareAtPrice != null) ...[
                const SizedBox(width: AppSpacing.s6),
                Text(
                  '${product.compareAtPrice} EGP',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
