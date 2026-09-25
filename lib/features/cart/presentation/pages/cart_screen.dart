import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_colors.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../cubit/cart_cubit.dart';
import '../../cubit/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isEmpty = state.items.isEmpty;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: _CartAppBar(
            itemCount: state.itemCount,
            onBack: () => context.pop(),
          ),
          body: isEmpty ? const _EmptyCartView() : _CartContent(state: state),
          bottomNavigationBar: isEmpty
              ? null
              : _CheckoutBar(
                  total: state.totalPrice,
                  onCheckout: () {
                    context.push(Routes.checkout);
                  },
                ),
        );
      },
    );
  }
}

class _CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CartAppBar({required this.itemCount, required this.onBack});

  final int itemCount;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: colorScheme.outlineVariant),
      ),
      titleSpacing: AppSpacing.s16,
      title: Row(
        children: [
          _HeaderButton(icon: Icons.arrow_back, onTap: onBack),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ATELIER',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.4,
                  ),
                ),
                const SizedBox(height: AppSpacing.s2),
                Text(
                  l10n.cartItemCount(itemCount),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(57);
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 19, color: colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      children: [
        _DeliveryBanner(subtotal: state.totalPrice),
        const SizedBox(height: AppSpacing.s24),
        const _SectionHeader(),
        const SizedBox(height: AppSpacing.s10),
        for (final item in state.items) ...[
          CartItemCard(item: item),
          const SizedBox(height: AppSpacing.s10),
        ],
        const SizedBox(height: AppSpacing.s8),
        const _PromoCard(),
        const SizedBox(height: AppSpacing.s16),
        CartSummary(subtotal: state.totalPrice),
        const SizedBox(height: AppSpacing.s24),
      ],
    );
  }
}

class _DeliveryBanner extends StatelessWidget {
  const _DeliveryBanner({required this.subtotal});

  final int subtotal;

  static const int freeDeliveryThreshold = 5000;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final remaining = freeDeliveryThreshold - subtotal;
    final isUnlocked = remaining <= 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.r12),
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              size: 20,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: AppSpacing.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUnlocked
                      ? l10n.cartDeliveryUnlockedTitle
                      : l10n.cartDeliveryAvailableTitle,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.s3),
                Text(
                  isUnlocked
                      ? l10n.cartFreeStandardShipping
                      : l10n.cartAddToFreeDelivery(_formatPrice(remaining)),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s8,
              vertical: AppSpacing.s4,
            ),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? AppColors.success.withValues(alpha: 0.12)
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.r4),
            ),
            child: Text(
              isUnlocked
                  ? l10n.cartUnlocked
                  : 'EGP ${_formatPrice(freeDeliveryThreshold)}',
              style: AppTextStyles.labelSmall.copyWith(
                color: isUnlocked
                    ? AppColors.success
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.cartItems,
            style: AppTextStyles.headingSmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          l10n.cartPricesInclVat,
          style: AppTextStyles.labelSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 18,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.s8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.cartPromoCode,
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              l10n.cartApply,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s52,
        AppSpacing.s20,
        AppSpacing.s40,
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.s20),
          Text(
            l10n.cartEmptyTitle,
            style: AppTextStyles.headingSmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(
            l10n.cartEmptyDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.s20),
          SizedBox(
            width: 240,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.go(Routes.shop);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onSurface,
                foregroundColor: colorScheme.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r9),
                ),
              ),
              child: Text(
                l10n.cartContinueShopping,
                style: AppTextStyles.button.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s40),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              l10n.cartExploreCategories,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          Wrap(
            spacing: AppSpacing.s8,
            runSpacing: AppSpacing.s8,
            children: [
              _CategoryPill(label: l10n.cartCategoryOvershirts),
              _CategoryPill(label: l10n.cartCategoryWidePants),
              _CategoryPill(label: l10n.cartCategoryBoxyTees),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s14,
        vertical: AppSpacing.s8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.total, required this.onCheckout});

  final int total;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: 80,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s20,
            AppSpacing.s12,
            AppSpacing.s20,
            AppSpacing.s14,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.97),
            border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                offset: const Offset(0, -5),
                color: Colors.black.withValues(alpha: 0.07),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.cartTotalBag,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s3),
                  Text(
                    _formatPrice(total),
                    style: AppTextStyles.priceMedium.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.s16),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.onSurface,
                      foregroundColor: colorScheme.surface,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r9),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock_outline, size: 15),
                        const SizedBox(width: AppSpacing.s6),
                        Flexible(
                          child: Text(
                            l10n.cartProceedToCheckout,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.button.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s6),
                        const Icon(Icons.arrow_forward, size: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(int value) {
    return 'EGP ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}';
  }
}
