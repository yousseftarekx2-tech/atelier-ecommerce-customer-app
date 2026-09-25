import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentSection extends StatefulWidget {
  const CheckoutPaymentSection({super.key});

  @override
  State<CheckoutPaymentSection> createState() => _CheckoutPaymentSectionState();
}

class _CheckoutPaymentSectionState extends State<CheckoutPaymentSection> {
  String _selectedMethod = 'cash_on_delivery';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '04  ' + l10n.checkoutPayment.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        _PaymentOption(
          title: l10n.checkoutCod,
          subtitle: l10n.checkoutCodSubtitle,
          icon: Icons.payments_outlined,
          value: 'cash_on_delivery',
          selectedValue: _selectedMethod,
          onTap: () {
            setState(() {
              _selectedMethod = 'cash_on_delivery';
            });
          },
        ),
        const SizedBox(height: 10),
        _PaymentOption(
          title: l10n.checkoutCard,
          subtitle: l10n.checkoutCardSubtitle,
          icon: Icons.credit_card_outlined,
          value: 'card',
          selectedValue: _selectedMethod,
          enabled: false,
          trailing: l10n.checkoutComingSoon,
          onTap: null,
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.selectedValue,
    required this.onTap,
    this.enabled = true,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String selectedValue;
  final VoidCallback? onTap;
  final bool enabled;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = value == selectedValue;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? colorScheme.onSurface
                : colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: enabled
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: enabled
                          ? colorScheme.onSurface
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            else
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 22,
                color: colorScheme.onSurface,
              ),
          ],
        ),
      ),
    );
  }
}
