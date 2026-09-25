import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../notifications/cubit/notifications_cubit.dart';
import '../../../notifications/cubit/notifications_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final surfaceColor = theme.colorScheme.surface;
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
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(
            l10n.profileTitle,
            style: AppTextStyles.headingSmall.copyWith(
              color: primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AuthAuthenticated) {
              return _AuthenticatedProfile(
                user: state.user,
                backgroundColor: backgroundColor,
                surfaceColor: surfaceColor,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                borderColor: borderColor,
              );
            }

            return _GuestProfile(
              surfaceColor: surfaceColor,
              primaryTextColor: primaryTextColor,
              secondaryTextColor: secondaryTextColor,
              borderColor: borderColor,
            );
          },
        ),
      ),
    );
  }
}

class _AuthenticatedProfile extends StatelessWidget {
  const _AuthenticatedProfile({
    required this.user,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.borderColor,
  });

  final AuthUser user;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s16,
        AppSpacing.s20,
        AppSpacing.s40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileIdentity(
            user: user,
            primaryTextColor: primaryTextColor,
            secondaryTextColor: secondaryTextColor,
          ),
          const Gap(AppSpacing.s28),
          _SectionTitle(
            title: l10n.profileAccountSection,
            color: secondaryTextColor,
          ),
          const Gap(AppSpacing.s8),
          _ProfileGroup(
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            children: [
              _ProfileTile(
                icon: Icons.shopping_bag_outlined,
                title: l10n.profileMyOrders,
                subtitle: l10n.profileMyOrdersSubtitle,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                onTap: () => context.push(Routes.orders),
              ),
              _ProfileTile(
                icon: Icons.auto_awesome_outlined,
                title: l10n.profileMyStyle,
                badge: l10n.profileStyleBadge,
                subtitle: l10n.profileMyStyleSubtitle,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                onTap: () => context.push(Routes.style),
              ),
              _ProfileTile(
                icon: Icons.history_rounded,
                title: l10n.profileRecentlyViewed,
                subtitle: l10n.profileRecentlyViewedSubtitle,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                onTap: () => context.push(Routes.view),
                showDivider: false,
              ),
            ],
          ),
          const Gap(AppSpacing.s24),
          _SectionTitle(
            title: l10n.profilePersonalSection,
            color: secondaryTextColor,
          ),
          const Gap(AppSpacing.s8),
          _ProfileGroup(
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            children: [
              _ProfileTile(
                icon: Icons.location_on_outlined,
                title: l10n.profileAddresses,
                subtitle: l10n.profileAddressesSubtitle,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                onTap: () => context.push(Routes.address),
              ),
              BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  return _ProfileTile(
                    icon: Icons.notifications_none_rounded,
                    title: l10n.profileNotifications,
                    badge: state.unreadCount > 0
                        ? '${state.unreadCount}'
                        : null,
                    subtitle: l10n.profileNotificationsSubtitle,
                    primaryTextColor: primaryTextColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () => context.push(Routes.notifications),
                    showDivider: false,
                  );
                },
              ),
            ],
          ),
          const Gap(AppSpacing.s24),
          _SectionTitle(
            title: l10n.profileAppSection,
            color: secondaryTextColor,
          ),
          const Gap(AppSpacing.s8),
          _ProfileGroup(
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            children: [
              _ProfileTile(
                icon: Icons.settings_outlined,
                title: l10n.profileSettings,
                subtitle: l10n.profileSettingsSubtitle,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                onTap: () => context.push(Routes.settings),
                showDivider: false,
              ),
            ],
          ),
          const Gap(AppSpacing.s24),
          _LogoutButton(
            primaryTextColor: primaryTextColor,
            borderColor: borderColor,
            onTap: () => _showSignOutDialog(context),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.profileLogoutTitle),
          content: Text(l10n.profileLogoutMessage),
          actions: [
            TextButton(
              onPressed: () => dialogContext.pop(),
              child: Text(l10n.profileCancel),
            ),
            FilledButton(
              onPressed: () {
                dialogContext.pop();
                context.read<AuthCubit>().signOut();
              },
              child: Text(l10n.profileLogout),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity({
    required this.user,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final AuthUser user;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = user.fullName?.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.profileMyAccount,
          style: AppTextStyles.labelSmall.copyWith(
            color: secondaryTextColor,
            letterSpacing: 1.6,
          ),
        ),
        const Gap(AppSpacing.s6),
        Text(
          name == null || name.isEmpty ? l10n.profileWelcomeBack : name,
          style: AppTextStyles.headingLarge.copyWith(
            color: primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(AppSpacing.s4),
        Text(
          user.email,
          style: AppTextStyles.bodyMedium.copyWith(color: secondaryTextColor),
        ),
      ],
    );
  }
}

class _GuestProfile extends StatelessWidget {
  const _GuestProfile({
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.borderColor,
  });

  final Color surfaceColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s16,
        AppSpacing.s20,
        AppSpacing.s40,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.s20),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(AppRadius.r16),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileGuestTitle,
              style: AppTextStyles.headingSmall.copyWith(
                color: primaryTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(AppSpacing.s8),
            Text(
              l10n.profileGuestDescription,
              style: AppTextStyles.bodySmall.copyWith(
                color: secondaryTextColor,
              ),
            ),
            const Gap(AppSpacing.s20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () => context.push(Routes.login),
                child: Text(l10n.profileSignIn),
              ),
            ),
            const Gap(AppSpacing.s10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () => context.push(Routes.register),
                child: Text(l10n.profileCreateAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Text(
        title,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          letterSpacing: 1.4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProfileGroup extends StatelessWidget {
  const _ProfileGroup({
    required this.children,
    required this.surfaceColor,
    required this.borderColor,
  });

  final List<Widget> children;
  final Color surfaceColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.onTap,
    this.badge,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;
  final String? badge;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                    ),
                    child: Icon(icon, size: 18, color: primaryTextColor),
                  ),
                  const Gap(AppSpacing.s14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: primaryTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (badge != null) ...[
                              const Gap(AppSpacing.s6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s6,
                                  vertical: AppSpacing.s2,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.r4,
                                  ),
                                ),
                                child: Text(
                                  badge!,
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: secondaryTextColor,
                                    fontSize: 9,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const Gap(AppSpacing.s4),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.s8),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: secondaryTextColor,
                  ),
                ],
              ),
            ),
            if (showDivider)
              Divider(
                height: 1,
                thickness: 1,
                indent: 66,
                endIndent: 0,
                color: Theme.of(context).dividerColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    required this.primaryTextColor,
    required this.borderColor,
    required this.onTap,
  });

  final Color primaryTextColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryTextColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r12),
          ),
        ),
        child: Text(
          l10n.profileLogout,
          style: AppTextStyles.button.copyWith(
            color: primaryTextColor,
            letterSpacing: 1.4,
          ),
        ),
      ),
    );
  }
}
