import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:atelier_customer/features/recently_viewed/cubit/recently_viewed_cubit.dart';
import 'package:atelier_customer/features/recently_viewed/cubit/recently_viewed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PrivacyDataScreen extends StatefulWidget {
  const PrivacyDataScreen({super.key});

  @override
  State<PrivacyDataScreen> createState() => _PrivacyDataScreenState();
}

class _PrivacyDataScreenState extends State<PrivacyDataScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecentlyViewedCubit>().loadRecentlyViewed();
  }

  Future<void> _clearRecentlyViewed() async {
    final l10n = AppLocalizations.of(context)!;

    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.privacyClearRecentlyViewedTitle),
          content: Text(l10n.privacyClearRecentlyViewedMessage),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: Text(l10n.privacyCancel),
            ),
            FilledButton(
              onPressed: () => context.pop(true),
              child: Text(l10n.privacyClear),
            ),
          ],
        );
      },
    );

    if (shouldClear != true || !mounted) {
      return;
    }

    await context.read<RecentlyViewedCubit>().clear();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.privacyRecentlyViewedCleared)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s20,
                  AppSpacing.s16,
                  AppSpacing.s20,
                  AppSpacing.s24,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: context.pop,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    Text(
                      l10n.privacyDataTitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.privacyDataIntro,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _PrivacySection(
                      title: l10n.privacyLocalDataTitle,
                      description: l10n.privacyLocalDataDescription,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
                      builder: (context, state) {
                        final count = state.productIds.length;
                        final isLoading =
                            state.status == RecentlyViewedStatus.loading;

                        return _PrivacyActionTile(
                          title: l10n.privacyRecentlyViewed,
                          subtitle: isLoading
                              ? l10n.privacyLoading
                              : l10n.privacyRecentlyViewedCount(count),
                          icon: Icons.history_outlined,
                          onTap: count == 0 ? null : _clearRecentlyViewed,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _PrivacySection(
                      title: l10n.privacyAccountDataTitle,
                      description: l10n.privacyAccountDataDescription,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    _PrivacyInfoTile(
                      title: l10n.privacyAccountData,
                      subtitle: l10n.privacyAccountDataSubtitle,
                      icon: Icons.person_outline,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTextStyles.labelSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _PrivacyActionTile extends StatelessWidget {
  const _PrivacyActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        enabled: onTap != null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s6,
        ),
        leading: Icon(icon, color: colorScheme.onSurface),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurface),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurfaceVariant,
        ),
        onTap: onTap,
      ),
    );
  }
}

class _PrivacyInfoTile extends StatelessWidget {
  const _PrivacyInfoTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s6,
        ),
        leading: Icon(icon, color: colorScheme.onSurface),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurface),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
