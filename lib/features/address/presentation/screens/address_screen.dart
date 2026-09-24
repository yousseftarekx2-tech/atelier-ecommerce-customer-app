import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/address_cubit.dart';
import '../../cubit/address_state.dart';
import '../../domain/entities/address.dart';
import 'address_form_screen.dart';
import 'location_picker_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'ADDRESSES',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.status == AddressStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          if (state.status == AddressStatus.loading &&
              state.addresses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.addresses.isEmpty) {
            return _EmptyAddresses(onAddAddress: () => _addAddress(context));
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<AddressCubit>().loadAddresses();
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
              children: [
                const Text(
                  'Manage your saved delivery addresses.',
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Manage your delivery addresses for seamless checkout.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF6F6D69),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _addAddress(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ADD NEW ADDRESS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ...state.addresses.map(
                  (address) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _AddressCard(
                      address: address,
                      onSetDefault: address.isDefault
                          ? null
                          : () => _setDefault(context, address),
                      onEdit: () => _editAddress(context, address),
                      onDelete: () => _deleteAddress(context, address),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Future<void> _addAddress(BuildContext context) async {
    final location = await Navigator.of(context).push<LocationPickerResult>(
      MaterialPageRoute(builder: (_) => const LocationPickerScreen()),
    );

    if (location == null || !context.mounted) {
      return;
    }

    await Navigator.of(context).push(
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
  }

  static Future<void> _editAddress(
    BuildContext context,
    Address address,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddressFormScreen(address: address)),
    );
  }

  static Future<void> _setDefault(BuildContext context, Address address) async {
    await context.read<AddressCubit>().setDefaultAddress(address.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Default address updated')));
  }

  static Future<void> _deleteAddress(
    BuildContext context,
    Address address,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9F9F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.delete_outline, size: 30),
              const SizedBox(height: 16),
              const Text(
                'DELETE THIS ADDRESS?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text(
                'This address will be removed from your saved addresses.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF6F6D69),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE6E4E0)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.fullName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      address.street,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6F6D69),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${address.city}, ${address.country}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6F6D69),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'DELETE ADDRESS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    await context.read<AddressCubit>().removeAddress(address.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Address removed')));
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.onSetDefault,
    required this.onEdit,
    required this.onDelete,
  });

  final Address address;
  final VoidCallback? onSetDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E4E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        address.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (address.isDefault)
                      const _Badge(text: 'DEFAULT')
                    else if (address.label.isNotEmpty)
                      _Badge(text: address.label.toUpperCase()),
                  ],
                ),
                const SizedBox(height: 14),
                if (address.phone.isNotEmpty)
                  Text(
                    address.phone,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6F6D69),
                    ),
                  ),
                if (address.phone.isNotEmpty) const SizedBox(height: 6),
                Text(
                  address.street,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  [
                    address.city,
                    if (address.governorate != null &&
                        address.governorate!.isNotEmpty)
                      address.governorate!,
                    address.country,
                  ].join(', '),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6F6D69),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE6E4E0))),
            ),
            child: Row(
              children: [
                if (onSetDefault != null)
                  Expanded(
                    child: _ActionButton(
                      label: 'SET AS DEFAULT',
                      onPressed: onSetDefault!,
                    ),
                  ),
                Expanded(
                  child: _ActionButton(label: 'EDIT', onPressed: onEdit),
                ),
                Expanded(
                  child: _ActionButton(label: 'DELETE', onPressed: onDelete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0ED),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(48),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _EmptyAddresses extends StatelessWidget {
  const _EmptyAddresses({required this.onAddAddress});

  final VoidCallback onAddAddress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off_outlined, size: 42),
            const SizedBox(height: 20),
            const Text(
              'NO SAVED ADDRESSES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add an address to make checkout faster.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF6F6D69),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onAddAddress,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'ADD NEW ADDRESS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
