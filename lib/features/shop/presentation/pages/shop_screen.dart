import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../cart/cubit/cart_state.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_state.dart';
import '../widgets/shop_category_chips.dart';
import '../widgets/shop_filter_sheet.dart';
import '../widgets/shop_product_grid.dart';
import '../widgets/shop_search_bar.dart';
import '../widgets/shop_sort_sheet.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  void _openProductDetails(BuildContext context, String productId) {
    context.push(Routes.productDetailsPath(productId));
  }

  Future<void> _openFilterSheet(BuildContext context, ShopLoaded state) async {
    final result = await showModalBottomSheet<ShopFilterResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) {
        return ShopFilterSheet(
          selectedMinPrice: state.selectedMinPrice,
          selectedMaxPrice: state.selectedMaxPrice,
          onlyAvailable: state.onlyAvailable,
          selectedSizes: state.selectedSizes,
        );
      },
    );

    if (result != null && context.mounted) {
      context.read<ShopCubit>().applyFilters(result);
    }
  }

  Future<void> _openSortSheet(BuildContext context, ShopLoaded state) async {
    final result = await showModalBottomSheet<ShopSortOption>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) {
        return ShopSortSheet(selectedOption: state.sortOption);
      },
    );

    if (result != null && context.mounted) {
      context.read<ShopCubit>().applySort(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final topSafeArea = MediaQuery.paddingOf(context).top;
    final headerHeight = topSafeArea + 56;

    return BlocProvider(
      create: (_) => ShopCubit(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        body: Stack(
          children: [
            BlocBuilder<ShopCubit, ShopState>(
              builder: (context, state) {
                if (state is ShopError) {
                  return Center(child: Text(state.message));
                }

                if (state is! ShopLoaded) {
                  return const SizedBox.shrink();
                }

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: headerHeight)),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.s20,
                        AppSpacing.s16,
                        AppSpacing.s20,
                        0,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          ShopSearchBar(
                            onChanged: context.read<ShopCubit>().search,
                          ),
                          const SizedBox(height: AppSpacing.s20),
                          ShopCategoryChips(
                            selectedCategory: state.selectedCategory,
                            onCategorySelected: context
                                .read<ShopCubit>()
                                .selectCategory,
                          ),
                          const SizedBox(height: AppSpacing.s24),
                          Row(
                            children: [
                              Text(
                                state.products.length == 1
                                    ? l10n.shopPiece(state.products.length)
                                    : l10n.shopPieces(state.products.length),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const Spacer(),
                              TextButton.icon(
                                onPressed: () {
                                  _openFilterSheet(context, state);
                                },
                                icon: const Icon(Icons.tune_rounded, size: 17),
                                label: Text(l10n.shopFilter),
                              ),
                              const SizedBox(width: AppSpacing.s4),
                              TextButton.icon(
                                onPressed: () {
                                  _openSortSheet(context, state);
                                },
                                icon: const Icon(
                                  Icons.swap_vert_rounded,
                                  size: 17,
                                ),
                                label: Text(l10n.shopSort),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s16),
                          if (state.products.isEmpty)
                            const _EmptyShopResult()
                          else
                            ShopProductGrid(
                              products: state.products,
                              onProductTap: (product) {
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
      ),
    );
  }
}

class _EmptyShopResult extends StatelessWidget {
  const _EmptyShopResult();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s48),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 40,
            color: colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: AppSpacing.s16),
          Text(
            l10n.shopNoProducts,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.s6),
          Text(
            l10n.shopTryAdjustingFilters,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}
