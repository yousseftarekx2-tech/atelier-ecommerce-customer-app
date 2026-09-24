import 'package:supabase_flutter/supabase_flutter.dart';

class StyleRemoteDataSource {
  StyleRemoteDataSource(this._supabase);
  User? get currentUser => _supabase.auth.currentUser;
  final SupabaseClient _supabase;

  Future<Map<String, dynamic>?> getStylePreferences(String userId) async {
    return await _supabase
        .from('style_preferences')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
  }

  Future<void> saveStylePreferences({
    required String userId,
    required List<String> styles,
    required List<String> colors,
    required List<String> lifestyles,
    required List<String> fits,
  }) async {
    await _supabase.from('style_preferences').upsert({
      'user_id': userId,
      'styles': styles,
      'colors': colors,
      'lifestyles': lifestyles,
      'fits': fits,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteStylePreferences(String userId) async {
    await _supabase.from('style_preferences').delete().eq('user_id', userId);
  }
}
