import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/routing/routes.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String _version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

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
                      l10n.aboutTitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s20,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.s16),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(
                          AppRadius.r24,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'A',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.surface,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Text(
                      'ATELIER',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Text(
                      l10n.aboutDescription,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    Material(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(
                        AppRadius.r16,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _AboutInfoRow(
                            title: l10n.aboutVersion,
                            value: _version,
                          ),
                          Divider(
                            height: 1,
                            color: colorScheme.outlineVariant,
                          ),
                          _AboutInfoRow(
                            title: l10n.aboutCopyright,
                            value: l10n.aboutLegalese,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _AboutActionTile(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.aboutPrivacy,
                      onTap: () {
                        context.push(Routes.privacyData);
                      },
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    _AboutActionTile(
                      icon: Icons.help_outline,
                      title: l10n.aboutSupport,
                      onTap: () {
                        context.push(Routes.helpSupport);
                      },
                    ),
                    const SizedBox(height: AppSpacing.s40),
                    Text(
                      l10n.aboutMadeFor,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
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

class _AboutInfoRow extends StatelessWidget {
  const _AboutInfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutActionTile extends StatelessWidget {
  const _AboutActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: colorScheme.onSurface,
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}