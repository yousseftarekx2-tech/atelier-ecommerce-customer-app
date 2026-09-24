import '../entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthUser?> signIn({required String email, required String password});

  Future<AuthUser?> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> updatePassword({required String password});

  Future<AuthUser?> updateFullName({required String fullName});

  Future<void> signOut();

  AuthUser? getCurrentUser();
}
