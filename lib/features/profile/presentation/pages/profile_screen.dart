import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/cubit/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(Routes.login);
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Text(
            'Profile',
            style: AppTextStyles.headingSmall.copyWith(color: primaryTextColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: AppTextStyles.labelMedium.copyWith(
                  color: secondaryTextColor,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.s12),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                  ),
                  leading: Icon(Icons.logout_outlined, color: primaryTextColor),
                  title: Text(
                    'Sign Out',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Sign out of your ATELIER account',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: secondaryTextColor,
                  ),
                  onTap: () => _showSignOutDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text(
            'Are you sure you want to sign out of your account?',
          ),
          actions: [
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                dialogContext.pop();
                context.read<AuthCubit>().signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}
