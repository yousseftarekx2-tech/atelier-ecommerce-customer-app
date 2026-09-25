import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CheckoutContactSection extends StatelessWidget {
  const CheckoutContactSection({
    super.key,
    required this.fullName,
    required this.email,
  });

  final String? fullName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '01  ' + l10n.checkoutContact.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (fullName != null && fullName!.isNotEmpty) ...[
                Text(
                  fullName!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
              ],
              if (email != null && email!.isNotEmpty)
                Text(
                  email!,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              if ((fullName == null || fullName!.isEmpty) &&
                  (email == null || email!.isEmpty))
                Text(
                  l10n.checkoutAccountUnavailable,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                l10n.checkoutPhoneOptional,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: l10n.checkoutPhoneHint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
