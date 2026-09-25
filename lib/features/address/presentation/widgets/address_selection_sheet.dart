import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/address/presentation/screens/address_form_screen.dart';
import 'package:atelier_customer/features/address/presentation/screens/location_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/address_cubit.dart';
import '../../cubit/address_state.dart';

class AddressSelectionSheet extends StatelessWidget {
  const AddressSelectionSheet({super.key});

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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6D4D0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.addressDeliveryTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ...state.addresses.map((address) {
                  final isSelected = address.id == state.selectedAddressId;

                  return InkWell(
                    onTap: () {
                      context.read<AddressCubit>().selectAddress(address.id);
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Colors.black
                              : const Color(0xFFE6E4E0),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _labelText(l10n, address.label),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  address.fullName,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${address.street}, ${address.city}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showAddAddressOptions(context);
                    },
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addressAddNew),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddAddressOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.addressAddNew,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.addressAddNewDescription,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    child: Icon(Icons.edit_location_alt_outlined),
                  ),
                  title: Text(
                    l10n.addressEnterManually,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(l10n.addressEnterManuallyDescription),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();

                    final saved = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (_) => const AddressFormScreen(),
                      ),
                    );

                    if (saved == true && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(child: Icon(Icons.map_outlined)),
                  title: Text(
                    l10n.addressChooseOnMap,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(l10n.addressChooseOnMapDescription),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();

                    final location = await Navigator.of(context)
                        .push<LocationPickerResult>(
                          MaterialPageRoute(
                            builder: (_) => const LocationPickerScreen(),
                          ),
                        );

                    if (location == null || !context.mounted) {
                      return;
                    }

                    final saved = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (_) => AddressFormScreen(
                          latitude: location.latitude,
                          longitude: location.longitude,
                          initialStreet: location.street,
                          initialCity: location.city,
                          initialGovernorate: location.governorate,
                          initialCountry: location.country,
                        ),
                      ),
                    );

                    if (saved == true && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
