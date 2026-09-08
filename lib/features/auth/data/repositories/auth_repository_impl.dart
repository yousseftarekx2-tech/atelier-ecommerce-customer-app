import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthUser?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.signIn(
      email: email,
      password: password,
    );

    return _mapUser(response.user);
  }

  @override
  Future<AuthUser?> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.signUp(
      fullName: fullName,
      email: email,
      password: password,
    );

    if (response.session == null) {
      return null;
    }

    return _mapUser(response.user);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) {
    return _remoteDataSource.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updatePassword({required String password}) {
    return _remoteDataSource.updatePassword(password: password);
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  AuthUser? getCurrentUser() {
    return _mapUser(_remoteDataSource.getCurrentUser());
  }

  AuthUser? _mapUser(supabase.User? user) {
    if (user == null) {
      return null;
    }

    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String?,
    );
  }
}
