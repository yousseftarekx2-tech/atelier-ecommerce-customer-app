import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const Duration _splashDuration = Duration(seconds: 3);

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    _lineAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOutCubic),
    );

    _startSplash();
  }

  Future<void> _startSplash() async {
    await Future.wait([
      _controller.forward(),
      Future<void>.delayed(_splashDuration),
    ]);

    if (!mounted) {
      return;
    }

    context.read<AuthCubit>().restoreSession();
  }

  Future<void> _handleUnauthenticated() async {
    final preferences = await SharedPreferences.getInstance();

    if (!mounted) {
      return;
    }

    final onboardingCompleted =
        preferences.getBool(_onboardingCompletedKey) ?? false;

    if (onboardingCompleted) {
      context.go(Routes.login);
    } else {
      context.go(Routes.onboarding);
    }
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.go(Routes.home);
      return;
    }

    if (state is AuthUnauthenticated || state is AuthFailure) {
      _handleUnauthenticated();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<AuthCubit, AuthState>(
      listener: _handleAuthState,
      child: Scaffold(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        body: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: child,
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ATELIER',
                    style: AppTextStyles.displayMedium.copyWith(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3.8,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  AnimatedBuilder(
                    animation: _lineAnimation,
                    builder: (context, child) {
                      return SizedBox(
                        width: 48 * _lineAnimation.value,
                        child: child,
                      );
                    },
                    child: Container(
                      height: 1,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
