import 'package:atelier_customer/features/address/cubit/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/address_cubit.dart';
import '../../domain/entities/address.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({
    super.key,
    this.address,
    this.latitude,
    this.longitude,
    this.initialStreet,
    this.initialCity,
    this.initialGovernorate,
    this.initialCountry,
  });

  final Address? address;
  final double? latitude;
  final double? longitude;
  final String? initialStreet;
  final String? initialCity;
  final String? initialGovernorate;
  final String? initialCountry;

  bool get isEditing => address != null;

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _governorateController;

  String _selectedLabel = 'Home';
  String _country = 'Egypt';
  bool _isDefault = false;
  bool _isSaving = false;

  static const _labels = ['Home', 'Work', 'Other'];

  @override
  void initState() {
    super.initState();

    final address = widget.address;

    _fullNameController = TextEditingController(text: address?.fullName ?? '');

    _phoneController = TextEditingController(text: address?.phone ?? '');

    _streetController = TextEditingController(
      text: address?.street ?? widget.initialStreet ?? '',
    );

    _cityController = TextEditingController(
      text: address?.city ?? widget.initialCity ?? '',
    );

    _governorateController = TextEditingController(
      text: address?.governorate ?? widget.initialGovernorate ?? '',
    );

    _country = address?.country ?? widget.initialCountry ?? 'Egypt';

    if (address != null) {
      _selectedLabel = _labels.contains(address.label)
          ? address.label
          : 'Other';

      _isDefault = address.isDefault;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.isEditing;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          isEditing ? 'EDIT ADDRESS' : 'NEW ADDRESS',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          children: [
            Text(
              isEditing
                  ? 'Update your delivery address.'
                  : 'Add a new delivery address.',
              style: const TextStyle(
                fontSize: 28,
                height: 1.15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Save your details for a faster checkout experience.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF6F6D69),
              ),
            ),
            const SizedBox(height: 32),
            _Field(
              controller: _fullNameController,
              label: 'FULL NAME',
              hint: 'Youssef Tarek',
              textInputAction: TextInputAction.next,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 20),
            _Field(
              controller: _phoneController,
              label: 'PHONE NUMBER',
              hint: '+20 10 9876 5432',
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            const Text(
              'ADDRESS LABEL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _labels.map((label) {
                final selected = _selectedLabel == label;

                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: _isSaving
                      ? null
                      : (_) {
                          setState(() {
                            _selectedLabel = label;
                          });
                        },
                  selectedColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFE0DED9)),
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _Field(
              controller: _streetController,
              label: 'STREET ADDRESS',
              hint: '15 El-Nasr Street, Apt 4B',
              textInputAction: TextInputAction.next,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 20),
            _Field(
              controller: _cityController,
              label: 'CITY',
              hint: 'Beni Suef',
              textInputAction: TextInputAction.next,
              validator: _requiredValidator,
            ),
            const SizedBox(height: 20),
            _Field(
              controller: _governorateController,
              label: 'GOVERNORATE',
              hint: 'Beni Suef',
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE6E4E0)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DEFAULT ADDRESS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Use this address as your primary delivery address.',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFF77736E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _isDefault,
                    onChanged: _isSaving
                        ? null
                        : (value) {
                            setState(() {
                              _isDefault = value;
                            });
                          },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSaving ? null : _save,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isEditing ? 'SAVE CHANGES' : 'SAVE ADDRESS',
                        style: const TextStyle(
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

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  Future<void> _save() async {
    if (_isSaving) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final cubit = context.read<AddressCubit>();

      final address = Address(
        id: widget.address?.id ?? '',
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        label: _selectedLabel,
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        governorate: _governorateController.text.trim().isEmpty
            ? null
            : _governorateController.text.trim(),
        country: _country,
        isDefault: _isDefault,
        latitude: widget.latitude ?? widget.address?.latitude,
        longitude: widget.longitude ?? widget.address?.longitude,
      );

      if (widget.isEditing) {
        await cubit.updateAddress(address);
      } else {
        await cubit.addAddress(address);
      }

      if (!mounted) {
        return;
      }

      if (cubit.state.status == AddressStatus.error) {
        return;
      }

      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.textInputAction,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFAAA7A2), fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE6E4E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE6E4E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
