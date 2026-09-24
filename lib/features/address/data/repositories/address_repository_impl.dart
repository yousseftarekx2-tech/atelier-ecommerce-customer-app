import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasource/address_remote_data_source.dart';

class AddressRepositoryImpl implements AddressRepository {
  AddressRepositoryImpl(this._remoteDataSource);

  final AddressRemoteDataSource _remoteDataSource;

  @override
  Future<List<Address>> getAddresses() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return const [];
    }

    final data = await _remoteDataSource.getAddresses(user.id);

    return data.map(_mapToEntity).toList();
  }

  @override
  Future<void> addAddress(Address address) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.addAddress(address: address, userId: user.id);
  }

  @override
  Future<void> updateAddress(Address address) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.updateAddress(address: address, userId: user.id);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.deleteAddress(
      addressId: addressId,
      userId: user.id,
    );
  }

  @override
  Future<void> setDefaultAddress(String addressId) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.setDefaultAddress(
      addressId: addressId,
      userId: user.id,
    );
  }

  Address _mapToEntity(Map<String, dynamic> data) {
    return Address(
      id: data['id'] as String,
      fullName: data['full_name'] as String,
      phone: data['phone'] as String,
      label: data['label'] as String,
      street: data['street'] as String,
      city: data['city'] as String,
      governorate: data['governorate'] as String?,
      country: data['country'] as String? ?? 'Egypt',
      isDefault: data['is_default'] as bool? ?? false,
      latitude: (data['latitude'] as num?)?.toDouble(),
      longitude: (data['longitude'] as num?)?.toDouble(),
    );
  }
}
