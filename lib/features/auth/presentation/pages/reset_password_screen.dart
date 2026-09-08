import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../cubit/auth_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });

    var isValid = true;

    if (password.isEmpty) {
      _passwordError = 'Please enter a new password.';
      isValid = false;
    } else if (password.length < 8) {
      _passwordError = 'Password must be at least 8 characters.';
      isValid = false;
    }

    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Please confirm your password.';
      isValid = false;
    } else if (password != confirmPassword) {
      _confirmPasswordError = 'Passwords do not match.';
      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    context.read<AuthCubit>().updatePassword(password: password);
  }

  void _goBack() {
    context.pop();
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthPasswordUpdated) {
      context.go(Routes.login);
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final mutedTextColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    final inputBackgroundColor = isDark
        ? AppColors.darkSurfaceMuted
        : AppColors.lightSurface;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final activeBorderColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.black;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: _handleAuthState,
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s24,
                    AppSpacing.s28,
                    AppSpacing.s24,
                    AppSpacing.s24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - AppSpacing.s52,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ATELIER',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: primaryTextColor,
                              letterSpacing: 2.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s40),
                        Text(
                          'Create a new password.',
                          style: AppTextStyles.headingLarge.copyWith(
                            color: primaryTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        Text(
                          'Choose a strong password to keep your account secure.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: secondaryTextColor,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s32),
                        _FieldLabel(
                          label: 'New Password',
                          color: secondaryTextColor,
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        TextField(
                          controller: _passwordController,
                          enabled: !isLoading,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            if (_passwordError != null) {
                              setState(() {
                                _passwordError = null;
                              });
                            }
                          },
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: primaryTextColor,
                          ),
                          decoration: _inputDecoration(
                            context: context,
                            hintText: 'Create a new password',
                            backgroundColor: inputBackgroundColor,
                            borderColor: _passwordError != null
                                ? AppColors.error
                                : borderColor,
                            activeBorderColor: activeBorderColor,
                            mutedTextColor: mutedTextColor,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        if (_passwordError != null) ...[
                          const SizedBox(height: AppSpacing.s6),
                          Text(
                            _passwordError!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.s16),
                        _FieldLabel(
                          label: 'Confirm Password',
                          color: secondaryTextColor,
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        TextField(
                          controller: _confirmPasswordController,
                          enabled: !isLoading,
                          obscureText: _obscureConfirmPassword,
                          textInputAction: TextInputAction.done,
                          onChanged: (_) {
                            if (_confirmPasswordError != null) {
                              setState(() {
                                _confirmPasswordError = null;
                              });
                            }
                          },
                          onSubmitted: (_) => _resetPassword(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: primaryTextColor,
                          ),
                          decoration: _inputDecoration(
                            context: context,
                            hintText: 'Confirm your new password',
                            backgroundColor: inputBackgroundColor,
                            borderColor: _confirmPasswordError != null
                                ? AppColors.error
                                : borderColor,
                            activeBorderColor: activeBorderColor,
                            mutedTextColor: mutedTextColor,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        if (_confirmPasswordError != null) ...[
                          const SizedBox(height: AppSpacing.s6),
                          Text(
                            _confirmPasswordError!,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Use at least 8 characters with a mix of letters and numbers.',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: mutedTextColor,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _resetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.black,
                              foregroundColor: isDark
                                  ? AppColors.black
                                  : AppColors.white,
                              disabledBackgroundColor: isDark
                                  ? AppColors.darkTextPrimary.withValues(
                                      alpha: 0.75,
                                    )
                                  : AppColors.black.withValues(alpha: 0.75),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.r12,
                                ),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: isDark
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                  )
                                : Text(
                                    'Reset Password',
                                    style: AppTextStyles.button.copyWith(
                                      color: isDark
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        Center(
                          child: TextButton.icon(
                            onPressed: isLoading ? null : _goBack,
                            style: TextButton.styleFrom(
                              foregroundColor: secondaryTextColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s12,
                                vertical: AppSpacing.s8,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_back, size: 16),
                            label: Text(
                              'Back',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration({
    required BuildContext context,
    required String hintText,
    required Color backgroundColor,
    required Color borderColor,
    required Color activeBorderColor,
    required Color mutedTextColor,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: mutedTextColor),
      filled: true,
      fillColor: backgroundColor,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(color: activeBorderColor),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: AppTextStyles.labelMedium.copyWith(
        color: color,
        letterSpacing: 1.2,
      ),
    );
  }
}
