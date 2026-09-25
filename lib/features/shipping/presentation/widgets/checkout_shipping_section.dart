import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shipping_cubit.dart';
import '../../cubit/shipping_state.dart';
import '../../domain/entities/shipping_method.dart';

class CheckoutShippingSection extends StatelessWidget {
  const CheckoutShippingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ShippingCubit, ShippingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '03  ' + l10n.checkoutShippingMethod.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            ...ShippingMethod.availableMethods.map((method) {
              final isSelected = method.id == state.selectedMethod.id;

              final price = isSelected
                  ? state.shippingCost
                  : method.costFor(subtotal: state.subtotal);

              final name = method.id == ShippingMethod.standard.id
                  ? l10n.shippingStandard
                  : l10n.shippingExpress;

              final description = method.id == ShippingMethod.standard.id
                  ? l10n.shippingStandardDescription
                  : l10n.shippingExpressDescription;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    context.read<ShippingCubit>().selectMethod(method);
                  },
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
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          size: 22,
                          color: colorScheme.onSurface,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          price == 0
                              ? l10n.checkoutFree
                              : 'EGP ' + price.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
