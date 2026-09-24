import 'package:atelier_customer/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../favorites/cubit/favorites_cubit.dart';

import '../../data/look_mock_data.dart';
import '../../domain/entities/look.dart';

class LookDetailsScreen extends StatefulWidget {
  const LookDetailsScreen({required this.lookId, super.key});

  final String lookId;

  @override
  State<LookDetailsScreen> createState() => _LookDetailsScreenState();
}

class _LookDetailsScreenState extends State<LookDetailsScreen> {
  Look? _look;

  final Map<String, String> _selectedSizes = {};

  @override
  void initState() {
    super.initState();

    _look = LookMockData.findById(widget.lookId);

    final look = _look;

    if (look == null) {
      return;
    }

    for (final product in look.products) {
      if (product.sizes.isEmpty) {
        continue;
      }

      _selectedSizes[product.id] = product.sizes.contains('M')
          ? 'M'
          : product.sizes.first;
    }
  }

  List<Product> get _availableProducts {
    return _look?.products.where((product) => product.stock > 0).toList() ?? [];
  }

  int get _bundleTotal {
    return _availableProducts.fold(
      0,
      (total, product) => total + product.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    final look = _look;

    if (look == null) {
      return Scaffold(
        body: Center(
          child: Text('Look not found', style: AppTextStyles.bodyLarge),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildAppBar(context)),
            SliverToBoxAdapter(child: _buildHero(look)),
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.s24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildLookInfo(look),
                  const Gap(AppSpacing.s40),
                  _buildShopTheLook(look),
                  const Gap(AppSpacing.s32),
                  _buildProducts(context, look),
                  const Gap(AppSpacing.s40),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildPurchaseBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SizedBox(
      height: AppSpacing.s64,
      child: Row(
        children: [
          IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back),
          ),
          const Spacer(),
          Text(
            'ATELIER',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 2.4,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildHero(Look look) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(look.heroImage, fit: BoxFit.cover),
          Positioned(
            left: AppSpacing.s24,
            right: AppSpacing.s24,
            bottom: AppSpacing.s24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  look.eyebrow,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                const Gap(AppSpacing.s4),
                Text(
                  look.title,
                  style: AppTextStyles.displayMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Gap(AppSpacing.s4),
                Text(
                  look.tag,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLookInfo(Look look) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(look.title, style: AppTextStyles.headingMedium),
        const Gap(AppSpacing.s8),
        Text(look.description, style: AppTextStyles.bodyLarge),
      ],
    );
  }

  Widget _buildShopTheLook(Look look) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Shop The Look', style: AppTextStyles.headingSmall),
            ),
            Text(
              '${look.availableProductCount} available',
              style: AppTextStyles.labelMedium,
            ),
          ],
        ),
        const Gap(AppSpacing.s8),
        Text(
          'Complete the outfit with the pieces selected for this look.',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildProducts(BuildContext context, Look look) {
    return Column(
      children: [
        for (var index = 0; index < look.products.length; index++) ...[
          _LookProductTile(
            product: look.products[index],
            selectedSize: _selectedSizes[look.products[index].id],
            onSizeChanged: look.products[index].stock <= 0
                ? null
                : (size) {
                    setState(() {
                      _selectedSizes[look.products[index].id] = size;
                    });
                  },
            onProductTap: () {
              context.push(Routes.productDetailsPath(look.products[index].id));
            },
            onFavorite: () {
              context.read<FavoritesCubit>().toggle(look.products[index].id);
            },
          ),
          if (index < look.products.length - 1)
            const Divider(height: AppSpacing.s40),
        ],
      ],
    );
  }

  Widget _buildPurchaseBar(BuildContext context) {
    final availableProducts = _availableProducts;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s24,
          AppSpacing.s12,
          AppSpacing.s24,
          AppSpacing.s12,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFFAFAF8),
          border: Border(top: BorderSide(color: Color(0xFFE6E4DE))),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Bundle Total', style: AppTextStyles.labelSmall),
                const Gap(AppSpacing.s2),
                Text(
                  // ignore: unnecessary_brace_in_string_interps
                  '${_bundleTotal} EGP',
                  style: AppTextStyles.priceMedium,
                ),
              ],
            ),
            const Gap(AppSpacing.s16),
            Expanded(
              child: FilledButton(
                onPressed: availableProducts.isEmpty
                    ? null
                    : () => _addAvailableItems(context),
                child: Text(
                  'Add Available Items (${availableProducts.length})',
                  style: AppTextStyles.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addAvailableItems(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    for (final product in _availableProducts) {
      final selectedSize = _selectedSizes[product.id];

      if (selectedSize == null || product.colors.isEmpty) {
        continue;
      }

      cartCubit.addItem(
        productId: product.id,
        size: selectedSize,
        color: product.colors.first,
        unitPrice: product.price,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_availableProducts.length} items added to your bag'),
      ),
    );
  }
}

class _LookProductTile extends StatelessWidget {
  const _LookProductTile({
    required this.product,
    required this.selectedSize,
    required this.onSizeChanged,
    required this.onProductTap,
    required this.onFavorite,
  });

  final Product product;
  final String? selectedSize;
  final ValueChanged<String>? onSizeChanged;
  final VoidCallback onProductTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final soldOut = product.stock <= 0;

    final isFavorite = context.watch<FavoritesCubit>().isFavorite(product.id);

    return Opacity(
      opacity: soldOut ? 0.55 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onProductTap,
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r16),
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),
          ),
          const Gap(AppSpacing.s16),
          Row(
            children: [
              Expanded(
                child: Text(product.name, style: AppTextStyles.headingSmall),
              ),
              IconButton(
                onPressed: soldOut ? null : onFavorite,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            ],
          ),
          Text(product.subtitle, style: AppTextStyles.bodySmall),
          const Gap(AppSpacing.s8),
          Text('${product.price} EGP', style: AppTextStyles.priceMedium),
          const Gap(AppSpacing.s16),
          if (soldOut)
            Text('SOLD OUT', style: AppTextStyles.labelMedium)
          else
            _SizeSelector(
              sizes: product.sizes,
              selectedSize: selectedSize,
              onChanged: onSizeChanged!,
            ),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  const _SizeSelector({
    required this.sizes,
    required this.selectedSize,
    required this.onChanged,
  });

  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.s8,
      runSpacing: AppSpacing.s8,
      children: sizes.map((size) {
        final selected = size == selectedSize;

        return ChoiceChip(
          label: Text(size, style: AppTextStyles.labelMedium),
          selected: selected,
          onSelected: (_) => onChanged(size),
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
        );
      }).toList(),
    );
  }
}
