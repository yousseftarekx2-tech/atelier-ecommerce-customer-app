import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/auth_user.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthInitial());

  final AuthRepository _authRepository;

  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading());

    try {
      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (user == null) {
        emit(const AuthFailure('Unable to sign in.'));
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = await _authRepository.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );

      if (user == null) {
        emit(
          const AuthRegistrationPending(
            'Account created. Please check your email to continue.',
          ),
        );
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(const AuthLoading());

    try {
      await _authRepository.sendPasswordResetEmail(email: email);

      emit(AuthPasswordResetEmailSent(email));
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  Future<void> updatePassword({required String password}) async {
    emit(const AuthLoading());

    try {
      await _authRepository.updatePassword(password: password);

      emit(const AuthPasswordUpdated());
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());

    try {
      await _authRepository.signOut();
      emit(const AuthUnauthenticated());
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  void restoreSession() {
    try {
      final user = _authRepository.getCurrentUser();

      if (user == null) {
        emit(const AuthUnauthenticated());
        return;
      }

      emit(AuthAuthenticated(user));
    } catch (error) {
      emit(AuthFailure(_mapError(error)));
    }
  }

  String _mapError(Object error) {
    final message = error.toString();

    if (message.contains('Invalid login credentials')) {
      return 'Invalid email or password.';
    }

    if (message.contains('User already registered')) {
      return 'An account with this email already exists.';
    }

    if (message.contains('Email not confirmed')) {
      return 'Please confirm your email before signing in.';
    }

    if (message.contains('Password should be at least')) {
      return 'Password does not meet the security requirements.';
    }

    if (message.contains('network')) {
      return 'Network error. Please check your connection.';
    }

    return error.toString();
  }
}
