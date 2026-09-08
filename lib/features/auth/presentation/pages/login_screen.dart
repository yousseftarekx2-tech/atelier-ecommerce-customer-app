import 'package:atelier_customer/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    var hasError = false;

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email address.';
      });
      hasError = true;
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address.';
      });
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password.';
      });
      hasError = true;
    }

    if (hasError) {
      return;
    }

    context.read<AuthCubit>().signIn(email: email, password: password);
  }

  void _forgotPassword() {
    context.push(Routes.forgotPassword);
  }

  void _continueWithGoogle() {}

  void _continueWithApple() {}

  void _continueAsGuest() {}

  void _createAccount() {
    context.push(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final inputBackgroundColor = isDark
        ? AppColors.darkSurfaceMuted
        : AppColors.lightSurface;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final mutedTextColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(Routes.home);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
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
                        const SizedBox(height: AppSpacing.s48),
                        Text(
                          'Welcome back.',
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
                          'Sign in to continue your style journey.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: secondaryTextColor,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s32),
                        _FieldLabel(label: 'Email', color: secondaryTextColor),
                        const SizedBox(height: AppSpacing.s6),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          enabled: !isLoading,
                          onChanged: (_) {
                            if (_emailError != null) {
                              setState(() {
                                _emailError = null;
                              });
                            }
                          },
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: primaryTextColor,
                          ),
                          decoration: _inputDecoration(
                            hintText: 'Email address',
                            backgroundColor: inputBackgroundColor,
                            borderColor: borderColor,
                            error: _emailError != null,
                            mutedTextColor: mutedTextColor,
                            isDark: isDark,
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
                        const SizedBox(height: AppSpacing.s16),
                        _FieldLabel(
                          label: 'Password',
                          color: secondaryTextColor,
                        ),
                        const SizedBox(height: AppSpacing.s6),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          enabled: !isLoading,
                          onChanged: (_) {
                            if (_passwordError != null) {
                              setState(() {
                                _passwordError = null;
                              });
                            }
                          },
                          onSubmitted: (_) => _signIn(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: primaryTextColor,
                          ),
                          decoration: _inputDecoration(
                            hintText: 'Password',
                            backgroundColor: inputBackgroundColor,
                            borderColor: borderColor,
                            error: _passwordError != null,
                            mutedTextColor: mutedTextColor,
                            isDark: isDark,
                            suffixIcon: IconButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: isLoading ? null : _forgotPassword,
                            style: TextButton.styleFrom(
                              foregroundColor: secondaryTextColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.s8,
                              ),
                            ),
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _signIn,
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
                                    'Sign In',
                                    style: AppTextStyles.button.copyWith(
                                      color: isDark
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s28),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: borderColor.withValues(alpha: 0.70),
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s12,
                              ),
                              child: Text(
                                'OR',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: secondaryTextColor,
                                  letterSpacing: 1.6,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: borderColor.withValues(alpha: 0.70),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        _SocialButton(
                          label: 'Continue with Google',
                          icon: _GoogleIcon(color: primaryTextColor),
                          backgroundColor: surfaceColor,
                          borderColor: borderColor,
                          textColor: primaryTextColor,
                          onPressed: isLoading ? () {} : _continueWithGoogle,
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        _SocialButton(
                          label: 'Continue with Apple',
                          icon: Icon(
                            Icons.apple,
                            size: 20,
                            color: primaryTextColor,
                          ),
                          backgroundColor: surfaceColor,
                          borderColor: borderColor,
                          textColor: primaryTextColor,
                          onPressed: isLoading ? () {} : _continueWithApple,
                        ),
                        const SizedBox(height: AppSpacing.s24),
                        Center(
                          child: TextButton.icon(
                            onPressed: isLoading ? null : _continueAsGuest,
                            style: TextButton.styleFrom(
                              foregroundColor: secondaryTextColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s12,
                                vertical: AppSpacing.s8,
                              ),
                            ),
                            iconAlignment: IconAlignment.end,
                            icon: const Icon(Icons.arrow_forward, size: 16),
                            label: Text(
                              'Continue as Guest',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s28),
                        Divider(
                          color: borderColor.withValues(alpha: 0.70),
                          height: 1,
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account? ',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: secondaryTextColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: isLoading ? null : _createAccount,
                                child: Text(
                                  'Create account',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: primaryTextColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1,
                                  ),
                                ),
                              ),
                            ],
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
    required String hintText,
    required Color backgroundColor,
    required Color borderColor,
    required Color mutedTextColor,
    required bool isDark,
    required bool error,
    Widget? suffixIcon,
  }) {
    final errorBorderColor = error ? AppColors.error : borderColor;

    final focusedBorderColor = error
        ? AppColors.error
        : isDark
        ? AppColors.darkTextPrimary
        : AppColors.black;

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
        borderSide: BorderSide(color: errorBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(color: focusedBorderColor, width: 1),
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

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: AppSpacing.s12),
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleIconPainter(color)),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  const _GoogleIconPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);

    canvas.drawArc(rect, -0.65, 4.65, false, paint);

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.5),
      Offset(size.width - 2, size.height * 0.5),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GoogleIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
