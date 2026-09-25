import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/recently_viewed/cubit/recently_viewed_cubit.dart';
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
import '../../data/product_mock_data.dart';
import '../../domain/entities/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.productId, super.key});

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final Product? _product;

  final PageController _galleryController = PageController();

  int _currentGalleryIndex = 0;
  late String _selectedColor;
  late String _selectedSize;

  @override
  void initState() {
    super.initState();

    _product = ProductMockData.findById(widget.productId);

    if (_product != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        context.read<RecentlyViewedCubit>().addProduct(_product.id);
      });

      _selectedColor = _product.colors.first;
      _selectedSize = _product.sizes.contains('M') ? 'M' : _product.sizes.first;
    } else {
      _selectedColor = '';
      _selectedSize = '';
    }
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final product = _product;

    if (product == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFAFAF8),
        appBar: _buildAppBar(context, null),
        body: Center(child: Text(l10n.productNotFound)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      appBar: _buildAppBar(context, product),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _buildGallery(context, product)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s20,
              AppSpacing.s24,
              AppSpacing.s20,
              150,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProductInfo(context, product),
                const Gap(AppSpacing.s24),
                _buildDivider(context),
                const Gap(AppSpacing.s24),
                _buildColorSection(context, product),
                const Gap(AppSpacing.s28),
                _buildSizeSection(context, product),
                const Gap(AppSpacing.s28),
                _buildAccordions(context, product),
                const Gap(AppSpacing.s32),
                _buildCompleteTheLook(context, product),
                const Gap(AppSpacing.s32),
                _buildReviews(context, product),
                const Gap(AppSpacing.s32),
                _buildRecommendations(context, product),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildPurchaseBar(context, product),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Product? product) {
    final isFavorite = product != null
        ? context.watch<FavoritesCubit>().isFavorite(product.id)
        : false;

    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'ATELIER',
          style: AppTextStyles.labelLarge.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
            color: const Color(0xFF151515),
          ),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _HeaderActionButton(
            icon: Icons.arrow_back_ios_new_rounded,
            iconSize: 17,
            onPressed: context.pop,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _HeaderActionButton(
              icon: isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              iconSize: 20,
              iconColor: isFavorite
                  ? const Color(0xFFE53935)
                  : const Color(0xFF151515),
              onPressed: product == null
                  ? null
                  : () {
                      context.read<FavoritesCubit>().toggle(product.id);
                    },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE6E4E0)),
        ),
      ),
    );
  }

  Widget _buildGallery(BuildContext context, Product product) {
    final images = product.galleryImages.isEmpty
        ? [product.image]
        : product.galleryImages;

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        color: const Color(0xFFF4F3F0),
        child: Stack(
          children: [
            PageView.builder(
              controller: _galleryController,
              itemCount: images.length,
              onPageChanged: (index) {
                if (!mounted) return;

                setState(() {
                  _currentGalleryIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                );
              },
            ),
            if (product.badge != null)
              Positioned(
                top: AppSpacing.s16,
                left: AppSpacing.s16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s10,
                    vertical: AppSpacing.s6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    product.badge!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFF151515),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: AppSpacing.s16,
              right: AppSpacing.s16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s10,
                  vertical: AppSpacing.s6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  '${_currentGalleryIndex + 1} / ${images.length}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: const Color(0xFF151515),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (images.length > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: AppSpacing.s16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    final selected = index == _currentGalleryIndex;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: selected ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: 24,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF151515),
          ),
        ),
        const Gap(AppSpacing.s10),
        if (product.rating != null)
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 15,
                color: Color(0xFFE0A52B),
              ),
              const Gap(AppSpacing.s4),
              Text(
                product.rating!.toStringAsFixed(1),
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF151515),
                ),
              ),
              if (product.reviewCount != null) ...[
                const Gap(AppSpacing.s4),
                Text(
                  '(${product.reviewCount} ${l10n.productReviews})',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ],
          ),
        const Gap(AppSpacing.s14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${product.price} EGP',
              style: AppTextStyles.priceLarge.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF151515),
              ),
            ),
            if (product.compareAtPrice != null) ...[
              const Gap(AppSpacing.s10),
              Text(
                '${product.compareAtPrice} EGP',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16,
                  color: const Color(0xFF999999),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const Gap(AppSpacing.s10),
              _buildDiscountBadge(context, product),
            ],
          ],
        ),
        const Gap(AppSpacing.s16),
        Text(
          product.description,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            height: 1.65,
            color: const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountBadge(BuildContext context, Product product) {
    final compareAtPrice = product.compareAtPrice;

    if (compareAtPrice == null || compareAtPrice <= product.price) {
      return const SizedBox.shrink();
    }

    final discount = ((compareAtPrice - product.price) / compareAtPrice * 100)
        .round();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s8,
        vertical: AppSpacing.s4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.r4),
      ),
      child: Text(
        '-$discount%',
        style: AppTextStyles.labelSmall.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFE53935),
        ),
      ),
    );
  }

  Widget _buildColorSection(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${l10n.productColor}: $_selectedColor',
          style: AppTextStyles.labelLarge.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        const Gap(AppSpacing.s12),
        Wrap(
          spacing: AppSpacing.s12,
          runSpacing: AppSpacing.s12,
          children: product.colors.map((color) {
            final selected = color == _selectedColor;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  _selectedColor = color;
                  _currentGalleryIndex = 0;
                });

                if (_galleryController.hasClients) {
                  _galleryController.jumpToPage(0);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: selected
                      ? Border.all(color: const Color(0xFF151515), width: 2)
                      : Border.all(color: Colors.transparent, width: 2),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _colorForName(color),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSizeSection(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;
    const sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.productSize,
              style: AppTextStyles.labelLarge.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _showSizeGuide(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.productSizeGuide,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 12,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.s10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sizes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            mainAxisExtent: 44,
          ),
          itemBuilder: (context, index) {
            final size = sizes[index];
            final available = product.sizes.contains(size);
            final selected = size == _selectedSize;

            return GestureDetector(
              onTap: available
                  ? () {
                      setState(() {
                        _selectedSize = size;
                      });
                    }
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF151515)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF151515)
                        : const Color(0xFFE6E4E0),
                  ),
                ),
                child: Text(
                  size,
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? Colors.white
                        : available
                        ? const Color(0xFF151515)
                        : const Color(0xFF151515).withValues(alpha: 0.35),
                    decoration: available ? null : TextDecoration.lineThrough,
                  ),
                ),
              ),
            );
          },
        ),
        const Gap(AppSpacing.s12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F3F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.fit != null)
                Text(
                  '${l10n.productFit}: ${product.fit}',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF666666),
                  ),
                ),
              if (product.fit != null) const Gap(4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: product.stock > 0
                          ? const Color(0xFF3A8F5B)
                          : const Color(0xFFE53935),
                    ),
                  ),
                  const Gap(6),
                  Text(
                    product.stock > 0
                        ? '${product.stock} ${l10n.productAvailable}'
                        : l10n.productOutOfStock,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: product.stock > 0
                          ? const Color(0xFF3A8F5B)
                          : const Color(0xFFE53935),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccordions(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _buildAccordion(
          title: l10n.productMaterialComposition,
          content: product.material ?? l10n.productMaterialFallback,
        ),
        _buildAccordion(
          title: l10n.productFitSilhouette,
          content: product.fit ?? l10n.productFitFallback,
          initiallyExpanded: true,
        ),
        _buildAccordion(
          title: l10n.productStyleAesthetics,
          content: product.styleTags.isEmpty
              ? l10n.productStyleFallback
              : product.styleTags.join(' • '),
        ),
        _buildAccordion(
          title: l10n.productCareInstructions,
          content: product.careInstructions ?? l10n.productCareFallback,
        ),
        _buildAccordion(
          title: l10n.productDeliveryReturns,
          content: product.deliveryInfo ?? l10n.productDeliveryFallback,
        ),
      ],
    );
  }

  Widget _buildAccordion({
    required String title,
    required String content,
    bool initiallyExpanded = false,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(vertical: 2),
        childrenPadding: const EdgeInsets.only(left: 0, right: 20, bottom: 16),
        shape: const Border(
          top: BorderSide(color: Color(0xFFE6E4E0), width: 1),
          bottom: BorderSide(color: Color(0xFFE6E4E0), width: 1),
        ),
        collapsedShape: const Border(
          bottom: BorderSide(color: Color(0xFFE6E4E0), width: 1),
        ),
        iconColor: const Color(0xFF151515),
        collapsedIconColor: const Color(0xFF151515),
        trailing: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
        title: Text(
          title,
          style: AppTextStyles.labelLarge.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              content,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 13,
                height: 1.55,
                color: const Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteTheLook(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    final products = ProductMockData.products
        .where(
          (item) =>
              item.id != product.id &&
              ['product_004', 'product_005', 'product_006'].contains(item.id),
        )
        .toList();

    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildHorizontalProductSection(
      context: context,
      title: l10n.productCompleteTheLook,
      subtitle: l10n.productCompleteTheLookSubtitle,
      products: products,
      cardWidth: 160,
      showQuickAdd: true,
    );
  }

  Widget _buildRecommendations(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    final products = ProductMockData.products
        .where((item) => item.id != product.id)
        .take(4)
        .toList();

    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildHorizontalProductSection(
      context: context,
      title: l10n.productYouMayAlsoLike,
      products: products,
      cardWidth: 144,
      showQuickAdd: false,
    );
  }

  Widget _buildHorizontalProductSection({
    required BuildContext context,
    required String title,
    required List<Product> products,
    required double cardWidth,
    String? subtitle,
    bool showQuickAdd = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF151515),
          ),
        ),
        if (subtitle != null) ...[
          const Gap(AppSpacing.s4),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: const Color(0xFF999999),
            ),
          ),
        ],
        const Gap(AppSpacing.s12),
        SizedBox(
          height: showQuickAdd ? 275 : 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemCount: products.length,
            separatorBuilder: (_, _) => const Gap(AppSpacing.s12),
            itemBuilder: (context, index) {
              final item = products[index];

              return _ProductMiniCard(
                product: item,
                width: cardWidth,
                showQuickAdd: showQuickAdd,
                onTap: () {
                  context.push(Routes.productDetailsPath(item.id));
                },
                onQuickAdd: showQuickAdd
                    ? () => _showQuickAddSheet(context, item)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviews(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;
    final rating = product.rating ?? 0;
    final reviewCount = product.reviewCount ?? 0;

    if (rating == 0 && reviewCount == 0) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDivider(context),
        const Gap(AppSpacing.s24),
        Text(
          l10n.productCustomerReviews,
          style: AppTextStyles.headingSmall.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF151515),
          ),
        ),
        const Gap(AppSpacing.s4),
        Text(
          l10n.productWhatCustomersAreSaying,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: const Color(0xFF999999),
          ),
        ),
        const Gap(AppSpacing.s16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F3F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: AppTextStyles.displayMedium.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF151515),
                ),
              ),
              const Gap(AppSpacing.s12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFE0A52B),
                        ),
                      ),
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '$reviewCount ${l10n.productCommunityRatings}',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.s12),
        _ReviewCard(
          name: l10n.productVerifiedCustomer,
          date: l10n.productReviewTwoWeeksAgo,
          text: l10n.productReviewGreatFit,
        ),
        const Gap(AppSpacing.s12),
        _ReviewCard(
          name: l10n.productVerifiedCustomer,
          date: l10n.productReviewOneMonthAgo,
          text: l10n.productReviewCleanSilhouette,
        ),
        const Gap(AppSpacing.s12),
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE6E4E0)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              l10n.productViewAllReviews(reviewCount),
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseBar(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    final canAdd =
        product.stock > 0 &&
        _selectedSize.isNotEmpty &&
        _selectedColor.isNotEmpty;

    final isAdded = context.select<CartCubit, bool>(
      (cartCubit) => cartCubit.state.items.any(
        (item) =>
            item.productId == product.id &&
            item.size == _selectedSize &&
            item.color == _selectedColor,
      ),
    );

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s20,
          AppSpacing.s14,
          AppSpacing.s20,
          AppSpacing.s14,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.97),
          border: const Border(top: BorderSide(color: Color(0xFFE6E4E0))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        '${product.price} EGP',
                        style: AppTextStyles.priceMedium.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF151515),
                        ),
                      ),
                      if (product.compareAtPrice != null) ...[
                        const Gap(AppSpacing.s6),
                        Text(
                          '${product.compareAtPrice} EGP',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            color: const Color(0xFF999999),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(AppSpacing.s3),
                  Text(
                    '$_selectedColor / $_selectedSize',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.s12),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: canAdd && !isAdded
                    ? () {
                        context.read<CartCubit>().addItem(
                          productId: product.id,
                          size: _selectedSize,
                          color: _selectedColor,
                          unitPrice: product.price,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.productAddedToCart),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: isAdded
                      ? const Color(0xFF3A8F5B)
                      : const Color(0xFF151515),
                  disabledBackgroundColor: isAdded
                      ? const Color(0xFF3A8F5B)
                      : const Color(0xFF151515).withValues(alpha: 0.35),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  isAdded ? Icons.check_rounded : Icons.shopping_bag_outlined,
                  size: 18,
                ),
                label: Text(
                  product.stock <= 0
                      ? l10n.productOutOfStockButton
                      : isAdded
                      ? l10n.productAddedToCartButton
                      : l10n.productAddToCart,
                  style: AppTextStyles.labelLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickAddSheet(BuildContext context, Product product) {
    final l10n = AppLocalizations.of(context)!;

    String selectedSize = product.sizes.contains('M')
        ? 'M'
        : product.sizes.isNotEmpty
        ? product.sizes.first
        : '';

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E4E0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.s18),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.productQuickAdd,
                                style: AppTextStyles.headingSmall.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF151515),
                                ),
                              ),
                              const Gap(4),
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 12,
                                  color: const Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          icon: const Icon(Icons.close_rounded, size: 20),
                        ),
                      ],
                    ),
                    const Gap(AppSpacing.s20),
                    Text(
                      l10n.productSelectSize,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF151515),
                      ),
                    ),
                    const Gap(AppSpacing.s10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: product.sizes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 40,
                          ),
                      itemBuilder: (context, index) {
                        final size = product.sizes[index];
                        final selected = size == selectedSize;

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFF151515)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selected
                                    ? const Color(0xFF151515)
                                    : const Color(0xFFE6E4E0),
                              ),
                            ),
                            child: Text(
                              size,
                              style: AppTextStyles.labelSmall.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF151515),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(AppSpacing.s20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: selectedSize.isEmpty || product.stock <= 0
                            ? null
                            : () {
                                context.read<CartCubit>().addItem(
                                  productId: product.id,
                                  size: selectedSize,
                                  color: product.colors.isNotEmpty
                                      ? product.colors.first
                                      : '',
                                  unitPrice: product.price,
                                );

                                Navigator.of(sheetContext).pop();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(l10n.productAddedToCart),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF151515),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.productAddToCart),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSizeGuide(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s20,
              0,
              AppSpacing.s20,
              AppSpacing.s24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.productSizeGuide,
                  style: AppTextStyles.headingSmall.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF151515),
                  ),
                ),
                const Gap(AppSpacing.s12),
                Text(
                  l10n.productSizeGuideDescription,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14,
                    height: 1.55,
                    color: const Color(0xFF666666),
                  ),
                ),
                const Gap(AppSpacing.s12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(height: 1, color: const Color(0xFFE6E4E0));
  }

  Color _colorForName(String name) {
    switch (name.toLowerCase()) {
      case 'washed bone':
      case 'bone white':
        return const Color(0xFFE7E0D3);

      case 'slate grey':
      case 'washed charcoal':
        return const Color(0xFF777777);

      case 'obsidian':
      case 'matte black':
        return const Color(0xFF151515);

      case 'raw sand':
        return const Color(0xFFC8B69A);

      case 'muted khaki':
        return const Color(0xFF8A8064);

      case 'dark umber':
        return const Color(0xFF49382D);

      case 'washed olive':
        return const Color(0xFF6D725C);

      default:
        return const Color(0xFFD0D0D0);
    }
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = 18,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F3F0),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor ?? const Color(0xFF151515),
          ),
        ),
      ),
    );
  }
}

class _ProductMiniCard extends StatelessWidget {
  const _ProductMiniCard({
    required this.product,
    required this.width,
    required this.onTap,
    this.showQuickAdd = false,
    this.onQuickAdd,
  });

  final Product product;
  final double width;
  final VoidCallback onTap;
  final bool showQuickAdd;
  final VoidCallback? onQuickAdd;

  @override
  Widget build(BuildContext context) {
    final imageHeight = width * 1.25;

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        product.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (showQuickAdd)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 1,
                        child: InkWell(
                          onTap: onQuickAdd,
                          customBorder: const CircleBorder(),
                          child: const SizedBox(
                            width: 32,
                            height: 32,
                            child: Icon(
                              Icons.add_rounded,
                              size: 19,
                              color: Color(0xFF151515),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Gap(AppSpacing.s8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelLarge.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
            const Gap(3),
            if (showQuickAdd && product.colors.isNotEmpty)
              Text(
                product.colors.first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  color: const Color(0xFF999999),
                ),
              ),
            if (showQuickAdd && product.colors.isNotEmpty) const Gap(3),
            Text(
              '${product.price} EGP',
              style: AppTextStyles.priceMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF151515),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.name, required this.text, this.date});

  final String name;
  final String text;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E4E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.verified_rounded,
                size: 15,
                color: Color(0xFF3A8F5B),
              ),
              const Gap(5),
              Text(
                name,
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3A8F5B),
                ),
              ),
              const Spacer(),
              if (date != null)
                Text(
                  date!,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 10,
                    color: const Color(0xFF999999),
                  ),
                ),
            ],
          ),
          const Gap(AppSpacing.s8),
          Row(
            children: List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: Color(0xFFE0A52B),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.s8),
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 13,
              height: 1.5,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}
