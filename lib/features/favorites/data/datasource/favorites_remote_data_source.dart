import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesRemoteDataSource {
  FavoritesRemoteDataSource(this._supabase);

  final SupabaseClient _supabase;

  Future<Set<String>> getFavoriteProductIds() async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      return {};
    }

    final response = await _supabase
        .from('favorites')
        .select('product_id')
        .eq('user_id', user.id);

    return response.map((row) => row['product_id'] as String).toSet();
  }

  Future<void> addFavorite(String productId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw StateError('User is not authenticated.');
    }

    await _supabase.from('favorites').insert({
      'user_id': user.id,
      'product_id': productId,
    });
  }

  Future<void> removeFavorite(String productId) async {
    final user = _supabase.auth.currentUser;

    if (user == null) {
      throw StateError('User is not authenticated.');
    }

    await _supabase
        .from('favorites')
        .delete()
        .eq('user_id', user.id)
        .eq('product_id', productId);
  }
}
