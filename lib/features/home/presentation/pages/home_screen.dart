import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/cart/cubit/cart_state.dart';
import 'package:atelier_customer/features/style/cubit/style_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../style/domain/entities/style_preferences.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../data/home_mock_data.dart';
import '../widgets/home_archive_cta.dart';
import '../widgets/home_collection_grid.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_section.dart';
import '../widgets/home_product_card.dart';
import '../widgets/home_product_section.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_shop_the_look.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openProductDetails(BuildContext context, String productId) {
    context.push(Routes.productDetailsPath(productId));
  }

  void _openShop(BuildContext context) {
    context.go(Routes.shop);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topSafeArea = MediaQuery.paddingOf(context).top;
    final headerHeight = topSafeArea + 56;

    return BlocListener<StyleCubit, StylePreferences>(
      listener: (context, preferences) {
        context.read<HomeCubit>().updateStylePreferences(preferences);
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        body: Stack(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeError) {
                  return Center(child: Text(state.message));
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
                          HomeSearchBar(
                            onChanged: context.read<HomeCubit>().search,
                          ),
                          const SizedBox(height: AppSpacing.s20),
                          if (state.isSearching)
                            _buildSearchResults(context, state)
                          else ...[
                            HomeHeroSection(
                              onExplorePressed: () => _openShop(context),
                            ),
                            const SizedBox(height: AppSpacing.s36),
                            HomeProductSection(
                              eyebrow: AppLocalizations.of(
                                context,
                              )!.homeFeatured,
                              title: AppLocalizations.of(
                                context,
                              )!.homePickedForYou,
                              description: AppLocalizations.of(
                                context,
                              )!.homePickedForYouDescription,
                              products: state.pickedForYou,
                              showViewAll: true,
                              onViewAllTap: () => _openShop(context),
                              onProductTap: (product) =>
                                  _openProductDetails(context, product.id),
                            ),
                            const SizedBox(height: AppSpacing.s36),
                            HomeShopTheLook(
                              onShopPressed: () => context.go(Routes.looks),
                            ),
                            const SizedBox(height: AppSpacing.s40),
                            HomeProductSection(
                              title: AppLocalizations.of(
                                context,
                              )!.homeTrendingNow,
                              products: state.trendingNow,
                              onProductTap: (product) =>
                                  _openProductDetails(context, product.id),
                            ),
                            const SizedBox(height: AppSpacing.s40),
                            HomeProductSection(
                              title: AppLocalizations.of(
                                context,
                              )!.homeNewArrivals,
                              description: AppLocalizations.of(
                                context,
                              )!.homeNewArrivalsDescription,
                              products: state.newArrivals,
                              onProductTap: (product) =>
                                  _openProductDetails(context, product.id),
                            ),
                            const SizedBox(height: AppSpacing.s40),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.homeExploreCollections,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: AppSpacing.s16),
                            HomeCollectionGrid(
                              collections: HomeMockData.collections,
                            ),
                            const SizedBox(height: AppSpacing.s40),
                            HomeArchiveCta(
                              onExplorePressed: () => _openShop(context),
                            ),
                            const SizedBox(height: 120),
                          ],
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
                    onCartPressed: () => context.push(Routes.cart),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, HomeState state) {
    final l10n = AppLocalizations.of(context)!;

    if (state.searchResults.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s48),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 40,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.45),
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              l10n.homeNoPiecesFound,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.s6),
            Text(
              l10n.homeTryAnotherSearch,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.homeSearchResults,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.s16),
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - AppSpacing.s16) / 2;
            final itemHeight = (itemWidth * 1.25) + 82;

            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.searchResults.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.s16,
                mainAxisSpacing: AppSpacing.s32,
                mainAxisExtent: itemHeight,
              ),
              itemBuilder: (context, index) {
                final product = state.searchResults[index];

                return HomeProductCard(
                  product: product,
                  onTap: () => _openProductDetails(context, product.id),
                );
              },
            );
          },
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}
