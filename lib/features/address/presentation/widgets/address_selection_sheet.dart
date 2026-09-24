import 'package:atelier_customer/features/address/presentation/screens/location_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../cubit/address_cubit.dart';
import '../../cubit/address_state.dart';

class AddressSelectionSheet extends StatelessWidget {
  const AddressSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                                  address.label,
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
                    onPressed: () async {
                      final location = await Navigator.of(context).push<LatLng>(
                        MaterialPageRoute(
                          builder: (_) => const LocationPickerScreen(),
                        ),
                      );

                      if (location == null) {
                        return;
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Address'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
