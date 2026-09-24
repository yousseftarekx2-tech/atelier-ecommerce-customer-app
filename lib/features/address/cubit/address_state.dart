import 'package:equatable/equatable.dart';

import '../domain/entities/address.dart';

enum AddressStatus { initial, loading, loaded, error }

sealed class AddressState extends Equatable {
  const AddressState({
    required this.status,
    required this.addresses,
    this.selectedAddressId,
    this.errorMessage,
  });

  final AddressStatus status;
  final List<Address> addresses;
  final String? selectedAddressId;
  final String? errorMessage;

  Address? get selectedAddress {
    if (selectedAddressId == null) {
      return null;
    }

    for (final address in addresses) {
      if (address.id == selectedAddressId) {
        return address;
      }
    }

    return null;
  }

  @override
  List<Object?> get props => [
    status,
    addresses,
    selectedAddressId,
    errorMessage,
  ];
}

final class AddressInitial extends AddressState {
  const AddressInitial()
    : super(status: AddressStatus.initial, addresses: const []);
}

final class AddressLoading extends AddressState {
  const AddressLoading({super.addresses = const [], super.selectedAddressId})
    : super(status: AddressStatus.loading);
}

final class AddressLoaded extends AddressState {
  const AddressLoaded({required super.addresses, super.selectedAddressId})
    : super(status: AddressStatus.loaded);
}

final class AddressError extends AddressState {
  const AddressError({
    required String message,
    super.addresses = const [],
    super.selectedAddressId,
  }) : super(status: AddressStatus.error, errorMessage: message);
}
