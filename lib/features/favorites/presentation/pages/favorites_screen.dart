import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/cubit/cart_state.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../../products/data/repositories/product_repository_impl.dart';
import '../../cubit/favorites_cubit.dart';
import '../../cubit/favorites_state.dart';
import '../widgets/favorites_product_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _openProductDetails(BuildContext context, String productId) {
    context.push(Routes.productDetailsPath(productId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repository = ProductRepositoryImpl();

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: Stack(
        children: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final favoriteProducts = repository
                  .getProducts()
                  .where((product) => state.productIds.contains(product.id))
                  .toList();

              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 72)),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.s20,
                      AppSpacing.s20,
                      AppSpacing.s20,
                      0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _FavoritesHeader(itemCount: favoriteProducts.length),
                        const SizedBox(height: AppSpacing.s24),
                        if (favoriteProducts.isEmpty)
                          const _EmptyFavorites()
                        else
                          FavoritesProductGrid(
                            products: favoriteProducts,
                            onProductTap: (product) {
                              _openProductDetails(context, product.id);
                            },
                            onQuickAdd: (product) {
                              _openProductDetails(context, product.id);
                            },
                          ),
                        const SizedBox(height: 120),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            bottom: false,
            child: BlocSelector<CartCubit, CartState, int>(
              selector: (state) => state.itemCount,
              builder: (context, cartItemCount) {
                return HomeHeader(
                  cartItemCount: cartItemCount,
                  onNotificationsPressed: () {},
                  onCartPressed: () {
                    context.push(Routes.cart);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesHeader extends StatelessWidget {
  const _FavoritesHeader({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.favoritesEyebrow,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 2,
            color: colorScheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: AppSpacing.s6),
        Text(
          l10n.favoritesTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.s8),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.favoritesSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            Text(
              l10n.favoritesItemCount(itemCount),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                letterSpacing: 1.2,
                color: colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 480,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.favoritesEyebrow,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 2,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: AppSpacing.s12),
              Text(
                l10n.favoritesEmptyTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                l10n.favoritesEmptyDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              FilledButton(
                onPressed: () {
                  context.go(Routes.shop);
                },
                child: Text(l10n.favoritesExploreShop),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
