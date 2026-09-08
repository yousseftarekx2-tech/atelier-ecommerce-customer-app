import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../cubit/auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  String? _emailError;

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  Color get _primaryTextColor =>
      _isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  Color get _secondaryTextColor =>
      _isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  Color get _mutedTextColor =>
      _isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

  Color get _inputBackgroundColor =>
      _isDark ? AppColors.darkSurface : AppColors.lightSurface;

  Color get _borderColor =>
      _isDark ? AppColors.darkBorder : AppColors.lightBorder;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _sendResetLink() {
    final email = _emailController.text.trim();

    setState(() {
      _emailError = null;
    });

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email address.';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address.';
      });
      return;
    }

    context.read<AuthCubit>().sendPasswordResetEmail(email: email);
  }

  void _goToLogin() {
    context.pop();
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthPasswordResetEmailSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent. Please check your email.'),
        ),
      );
      return;
    }

    if (state is AuthFailure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _handleAuthState,
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: _isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s24,
                vertical: AppSpacing.s24,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ATELIER',
                      style: AppTextStyles.headingMedium.copyWith(
                        color: _primaryTextColor,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s48),
                    Text(
                      'Forgot your password?',
                      style: AppTextStyles.headingLarge.copyWith(
                        color: _primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Text(
                      "Enter your email and we'll send you a password reset link.",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _secondaryTextColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s32),
                    Text(
                      'Email',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: _primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    TextField(
                      controller: _emailController,
                      enabled: !isLoading,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) {
                        if (_emailError != null) {
                          setState(() {
                            _emailError = null;
                          });
                        }
                      },
                      onSubmitted: (_) => _sendResetLink(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _primaryTextColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: _mutedTextColor,
                        ),
                        filled: true,
                        fillColor: _inputBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                          vertical: AppSpacing.s16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                          borderSide: BorderSide(color: _borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                          borderSide: BorderSide(
                            color: _emailError != null
                                ? AppColors.error
                                : _borderColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                          borderSide: BorderSide(
                            color: _emailError != null
                                ? AppColors.error
                                : _isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    if (_emailError != null) ...[
                      const SizedBox(height: AppSpacing.s6),
                      Text(
                        _emailError!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.s24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _sendResetLink,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isDark
                              ? AppColors.white
                              : AppColors.black,
                          foregroundColor: _isDark
                              ? AppColors.black
                              : AppColors.white,
                          disabledBackgroundColor: _isDark
                              ? AppColors.darkSurfaceMuted
                              : AppColors.lightSurfaceMuted,
                          disabledForegroundColor: _mutedTextColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.r12),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _isDark
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
                              )
                            : Text(
                                'Send Reset Link',
                                style: AppTextStyles.button.copyWith(
                                  color: _isDark
                                      ? AppColors.black
                                      : AppColors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Center(
                      child: TextButton(
                        onPressed: isLoading ? null : _goToLogin,
                        child: Text(
                          'Back to Sign In',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: _primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
