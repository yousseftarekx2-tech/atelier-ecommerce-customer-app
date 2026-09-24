import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/address.dart';

class AddressRemoteDataSource {
  AddressRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  User? get currentUser => _supabase.auth.currentUser;

  Future<List<Map<String, dynamic>>> getAddresses(String userId) async {
    final response = await _supabase
        .from('addresses')
        .select()
        .eq('user_id', userId)
        .order('is_default', ascending: false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addAddress({
    required Address address,
    required String userId,
  }) async {
    await _supabase.from('addresses').insert({
      'user_id': userId,
      'full_name': address.fullName,
      'phone': address.phone,
      'label': address.label,
      'street': address.street,
      'city': address.city,
      'governorate': address.governorate,
      'country': address.country,
      'is_default': address.isDefault,
      'latitude': address.latitude,
      'longitude': address.longitude,
    });
  }

  Future<void> updateAddress({
    required Address address,
    required String userId,
  }) async {
    await _supabase
        .from('addresses')
        .update({
          'full_name': address.fullName,
          'phone': address.phone,
          'label': address.label,
          'street': address.street,
          'city': address.city,
          'governorate': address.governorate,
          'country': address.country,
          'is_default': address.isDefault,
          'latitude': address.latitude,
          'longitude': address.longitude,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', address.id)
        .eq('user_id', userId);
  }

  Future<void> deleteAddress({
    required String addressId,
    required String userId,
  }) async {
    await _supabase
        .from('addresses')
        .delete()
        .eq('id', addressId)
        .eq('user_id', userId);
  }

  Future<void> setDefaultAddress({
    required String addressId,
    required String userId,
  }) async {
    await _supabase
        .from('addresses')
        .update({
          'is_default': false,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('user_id', userId)
        .eq('is_default', true);

    await _supabase
        .from('addresses')
        .update({
          'is_default': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', addressId)
        .eq('user_id', userId);
  }
}
