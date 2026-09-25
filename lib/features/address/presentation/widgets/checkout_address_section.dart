import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/address/presentation/widgets/address_selection_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/address_cubit.dart';
import '../../cubit/address_state.dart';

class CheckoutAddressSection extends StatelessWidget {
  const CheckoutAddressSection({super.key});

  String _labelText(AppLocalizations l10n, String label) {
    switch (label) {
      case 'Home':
        return l10n.addressLabelHome;
      case 'Work':
        return l10n.addressLabelWork;
      default:
        return l10n.addressLabelOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        final address = state.selectedAddress;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.checkoutShippingAddressTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE6E4E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: address == null
                  ? Text(
                      l10n.checkoutNoAddressSelected,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF777777),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _labelText(l10n, address.label),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final addressCubit = context
                                    .read<AddressCubit>();

                                showModalBottomSheet(
                                  context: context,
                                  showDragHandle: false,
                                  isScrollControlled: true,
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: addressCubit,
                                      child: const AddressSelectionSheet(),
                                    );
                                  },
                                );
                              },
                              child: Text(l10n.addressChange),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          address.fullName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address.street,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777777),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address.city,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777777),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          address.phone,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}
