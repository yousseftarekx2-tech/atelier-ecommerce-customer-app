import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_colors.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.subtotal});

  final int subtotal;

  static const int freeDeliveryThreshold = 5000;
  static const int standardShipping = 80;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final hasFreeShipping = subtotal >= freeDeliveryThreshold;
    final shipping = hasFreeShipping ? 0 : standardShipping;
    final total = subtotal + shipping;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.s16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.r12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.cartSummary,
                style: AppTextStyles.labelMedium.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              _SummaryRow(
                label: l10n.cartSubtotal,
                value: _formatPrice(subtotal),
              ),
              const SizedBox(height: AppSpacing.s10),
              _SummaryRow(
                label: l10n.cartEstimatedShipping,
                value: hasFreeShipping
                    ? l10n.cartFree
                    : _formatPrice(standardShipping),
                valueColor: hasFreeShipping
                    ? AppColors.success
                    : colorScheme.onSurface,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.s14),
                child: Divider(height: 1, color: colorScheme.outlineVariant),
              ),
              _SummaryRow(
                label: l10n.cartTotal,
                value: _formatPrice(total),
                isTotal: true,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                l10n.cartTaxesIncluded,
                style: AppTextStyles.labelSmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        Row(
          children: [
            Expanded(
              child: _TrustBadge(
                icon: Icons.lock_outline,
                text: l10n.cartSecureCheckout,
              ),
            ),
            const SizedBox(width: AppSpacing.s8),
            Expanded(
              child: _TrustBadge(
                icon: Icons.assignment_return_outlined,
                text: l10n.cartFreeReturns,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatPrice(int value) {
    return 'EGP ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isTotal
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.priceMedium.copyWith(
            color: valueColor ?? colorScheme.onSurface,
            fontSize: isTotal ? 16 : 12,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.r9),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.s6),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
