import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/address.dart';
import '../domain/repositories/address_repository.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._repository) : super(const AddressInitial());

  final AddressRepository _repository;

  Future<void> loadAddresses() async {
    emit(
      AddressLoading(
        addresses: state.addresses,
        selectedAddressId: state.selectedAddressId,
      ),
    );

    try {
      final addresses = await _repository.getAddresses();

      final selectedAddressId = _resolveSelectedAddressId(addresses);

      emit(
        AddressLoaded(
          addresses: addresses,
          selectedAddressId: selectedAddressId,
        ),
      );
    } catch (error) {
      emit(
        AddressError(
          message: error.toString(),
          addresses: state.addresses,
          selectedAddressId: state.selectedAddressId,
        ),
      );
    }
  }

  void selectAddress(String addressId) {
    final exists = state.addresses.any(
      (address) => address.id == addressId,
    );

    if (!exists) {
      return;
    }

    emit(
      AddressLoaded(
        addresses: state.addresses,
        selectedAddressId: addressId,
      ),
    );
  }

  Future<void> addAddress(Address address) async {
    try {
      await _repository.addAddress(address);

      await loadAddresses();
    } catch (error) {
      emit(
        AddressError(
          message: error.toString(),
          addresses: state.addresses,
          selectedAddressId: state.selectedAddressId,
        ),
      );
    }
  }

  Future<void> updateAddress(Address address) async {
    try {
      await _repository.updateAddress(address);

      await loadAddresses();
    } catch (error) {
      emit(
        AddressError(
          message: error.toString(),
          addresses: state.addresses,
          selectedAddressId: state.selectedAddressId,
        ),
      );
    }
  }

  Future<void> removeAddress(String addressId) async {
    try {
      await _repository.deleteAddress(addressId);

      await loadAddresses();
    } catch (error) {
      emit(
        AddressError(
          message: error.toString(),
          addresses: state.addresses,
          selectedAddressId: state.selectedAddressId,
        ),
      );
    }
  }

  Future<void> setDefaultAddress(String addressId) async {
    try {
      await _repository.setDefaultAddress(addressId);

      final addresses = await _repository.getAddresses();

      emit(
        AddressLoaded(
          addresses: addresses,
          selectedAddressId: addressId,
        ),
      );
    } catch (error) {
      emit(
        AddressError(
          message: error.toString(),
          addresses: state.addresses,
          selectedAddressId: state.selectedAddressId,
        ),
      );
    }
  }

  String? _resolveSelectedAddressId(List<Address> addresses) {
    if (addresses.isEmpty) {
      return null;
    }

    final currentSelectedId = state.selectedAddressId;

    if (currentSelectedId != null) {
      final currentSelectedExists = addresses.any(
        (address) => address.id == currentSelectedId,
      );

      if (currentSelectedExists) {
        return currentSelectedId;
      }
    }

    for (final address in addresses) {
      if (address.isDefault) {
        return address.id;
      }
    }

    return addresses.first.id;
  }
}