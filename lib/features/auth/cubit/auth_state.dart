part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final AuthUser user;

  @override
  List<Object?> get props => [user.id, user.email, user.fullName];
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthRegistrationPending extends AuthState {
  const AuthRegistrationPending(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class AuthPasswordResetEmailSent extends AuthState {
  const AuthPasswordResetEmailSent(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class AuthPasswordUpdated extends AuthState {
  const AuthPasswordUpdated();
}

final class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
