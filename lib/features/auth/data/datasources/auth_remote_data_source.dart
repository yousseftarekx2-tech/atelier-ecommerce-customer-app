import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const String passwordResetRedirectUrl = 'atelier://reset-password';

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUp({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  Future<void> sendPasswordResetEmail({required String email}) {
    return _client.auth.resetPasswordForEmail(
      email,
      redirectTo: passwordResetRedirectUrl,
    );
  }

  Future<void> updatePassword({required String password}) async {
    await _client.auth.updateUser(UserAttributes(password: password));
  }

  Future<void> signOut() {
    return _client.auth.signOut();
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }
}
