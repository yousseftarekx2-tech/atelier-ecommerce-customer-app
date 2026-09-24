import 'package:atelier_customer/core/routing/routes.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:atelier_customer/features/home/presentation/widgets/home_product_card.dart';
import 'package:atelier_customer/features/products/data/product_mock_data.dart';
import 'package:atelier_customer/features/products/domain/entities/product.dart';
import 'package:atelier_customer/features/recently_viewed/cubit/recently_viewed_cubit.dart';
import 'package:atelier_customer/features/recently_viewed/cubit/recently_viewed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<RecentlyViewedCubit>().loadRecentlyViewed();
    });
  }

  List<Product> _resolveProducts(List<String> productIds) {
    return productIds
        .map(ProductMockData.findById)
        .whereType<Product>()
        .toList();
  }

  Future<void> _clearHistory() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r16),
          ),
          title: Text(
            'Clear Recently Viewed',
            style: AppTextStyles.headingSmall,
          ),
          content: Text(
            'Are you sure you want to clear your recently viewed history?',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel', style: AppTextStyles.bodyMedium),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Clear', style: AppTextStyles.bodyMedium),
            ),
          ],
        );
      },
    );

    if (shouldClear != true || !mounted) {
      return;
    }

    await context.read<RecentlyViewedCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('RECENTLY VIEWED', style: AppTextStyles.headingSmall),
        centerTitle: true,
      ),
      body: BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
        builder: (context, state) {
          switch (state.status) {
            case RecentlyViewedStatus.initial:
            case RecentlyViewedStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case RecentlyViewedStatus.error:
              return _ErrorView(
                onRetry: () {
                  context.read<RecentlyViewedCubit>().loadRecentlyViewed();
                },
              );

            case RecentlyViewedStatus.loaded:
              final products = _resolveProducts(state.productIds);

              if (products.isEmpty) {
                return const _EmptyView();
              }

              return _RecentlyViewedContent(
                products: products,
                onClear: _clearHistory,
              );
          }
        },
      ),
    );
  }
}

class _RecentlyViewedContent extends StatelessWidget {
  const _RecentlyViewedContent({required this.products, required this.onClear});

  final List<Product> products;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s24,
            AppSpacing.s16,
            0,
          ),
          sliver: SliverToBoxAdapter(child: _Intro(itemCount: products.length)),
        ),
        const SliverGap(AppSpacing.s24),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  context.push(Routes.productDetailsPath(product.id));
                },
                child: HomeProductCard(product: product),
              );
            }, childCount: products.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.s12,
              mainAxisSpacing: AppSpacing.s28,
              childAspectRatio: 0.58,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s40,
            AppSpacing.s16,
            AppSpacing.s32,
          ),
          sliver: SliverToBoxAdapter(child: _Footer(onClear: onClear)),
        ),
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RECENTLY VIEWED', style: AppTextStyles.headingLarge),
        const Gap(AppSpacing.s4),
        Text('$itemCount ITEMS', style: AppTextStyles.labelMedium),
        const Gap(AppSpacing.s16),
        Text(
          "Pieces you've explored recently.",
          style: AppTextStyles.bodyLarge,
        ),
        const Gap(AppSpacing.s4),
        Text(
          'Curated from your active browsing footprint.',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onClear,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, AppSpacing.s48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
              ),
            ),
            child: Text(
              'Clear Recently Viewed History',
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ),
        const Gap(AppSpacing.s12),
        Text(
          'Session items are retained locally across visits.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history_outlined, size: AppSpacing.s48),
            const Gap(AppSpacing.s16),
            Text(
              'Nothing here yet',
              style: AppTextStyles.headingSmall,
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.s8),
            Text(
              'Products you explore will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: AppSpacing.s48),
            const Gap(AppSpacing.s16),
            Text(
              'Something went wrong',
              style: AppTextStyles.headingSmall,
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.s16),
            OutlinedButton(
              onPressed: onRetry,
              child: Text('Try Again', style: AppTextStyles.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
