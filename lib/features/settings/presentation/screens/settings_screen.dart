import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../cubit/settings_cubit.dart';
import '../../cubit/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s20,
                  AppSpacing.s16,
                  AppSpacing.s20,
                  AppSpacing.s32,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: context.pop,
                      icon: Icon(Icons.arrow_back, color: primaryTextColor),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    Text(
                      l10n.settingsTitle,
                      style: AppTextStyles.headingMedium.copyWith(
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                child: Text(
                  l10n.settingsSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s40)),
            SliverToBoxAdapter(
              child: _SettingsSection(
                number: '01',
                title: l10n.settingsPreferences,
                children: [
                  const _AppearanceTile(),
                  _SettingsTile(
                    icon: Icons.language_outlined,
                    title: l10n.settingsLanguage,
                    subtitle: l10n.settingsLanguageSubtitle,
                    onTap: () => _showLanguageSheet(context),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: _SettingsSection(
                number: '02',
                title: l10n.settingsAccount,
                children: [
                  _SettingsTile(
                    icon: Icons.person_outline,
                    title: l10n.settingsAccountInformation,
                    subtitle: l10n.settingsAccountInformationSubtitle,
                    onTap: () => context.push(Routes.accountInformation),
                  ),
                  _SettingsTile(
                    icon: Icons.lock_outline,
                    title: l10n.settingsPasswordSecurity,
                    subtitle: l10n.settingsPasswordSecuritySubtitle,
                    onTap: () => context.push(Routes.passwordSecurity),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: _SettingsSection(
                number: '03',
                title: l10n.settingsPrivacy,
                children: [
                  _SettingsTile(
                    icon: Icons.privacy_tip_outlined,
                    title: l10n.settingsPrivacyData,
                    subtitle: l10n.settingsPrivacyDataSubtitle,
                    onTap: () => context.push(Routes.privacyData),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: _SettingsSection(
                number: '04',
                title: l10n.settingsSupport,
                children: [
                  _SettingsTile(
                    icon: Icons.help_outline,
                    title: l10n.settingsHelpSupport,
                    subtitle: l10n.settingsHelpSupportSubtitle,
                    onTap: () => context.push(Routes.helpSupport),
                  ),
                  _SettingsTile(
                    icon: Icons.info_outline,
                    title: l10n.settingsAbout,
                    subtitle: l10n.settingsAboutSubtitle,
                    onTap: () => context.push(Routes.about),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s48)),
          ],
        ),
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.r24),
        ),
      ),
      builder: (_) => const _LanguageSheet(),
    );
  }
}

class _AppearanceTile extends StatelessWidget {
  const _AppearanceTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final value = switch (state.appearance) {
          AppAppearance.system => l10n.appearanceSystem,
          AppAppearance.light => l10n.appearanceLight,
          AppAppearance.dark => l10n.appearanceDark,
        };

        return _SettingsTile(
          icon: Icons.brightness_6_outlined,
          title: l10n.settingsAppearance,
          subtitle: value,
          onTap: () => _showAppearanceSheet(context),
        );
      },
    );
  }

  void _showAppearanceSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.r24),
        ),
      ),
      builder: (_) => const _AppearanceSheet(),
    );
  }
}

class _AppearanceSheet extends StatelessWidget {
  const _AppearanceSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s20,
            AppSpacing.s24,
            AppSpacing.s20,
            AppSpacing.s32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.settingsAppearance, style: AppTextStyles.headingSmall),
              const SizedBox(height: AppSpacing.s20),
              RadioGroup<AppAppearance>(
                groupValue: state.appearance,
                onChanged: (value) {
                  if (value == null) return;

                  context.read<SettingsCubit>().setAppearance(value);
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    for (final appearance in AppAppearance.values)
                      RadioListTile<AppAppearance>(
                        value: appearance,
                        title: Text(switch (appearance) {
                          AppAppearance.system => l10n.appearanceSystem,
                          AppAppearance.light => l10n.appearanceLight,
                          AppAppearance.dark => l10n.appearanceDark,
                        }),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s20,
            AppSpacing.s24,
            AppSpacing.s20,
            AppSpacing.s32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.settingsLanguage, style: AppTextStyles.headingSmall),
              const SizedBox(height: AppSpacing.s20),
              RadioGroup<AppLanguage>(
                groupValue: state.language,
                onChanged: (value) {
                  if (value == null) return;

                  context.read<SettingsCubit>().setLanguage(value);
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    for (final language in AppLanguage.values)
                      RadioListTile<AppLanguage>(
                        value: language,
                        title: Text(switch (language) {
                          AppLanguage.english => l10n.languageEnglish,
                          AppLanguage.arabic => l10n.languageArabic,
                        }),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.number,
    required this.title,
    required this.children,
  });

  final String number;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final mutedTextColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s32,
        AppSpacing.s20,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number / $title',
            style: AppTextStyles.labelMedium.copyWith(color: mutedTextColor),
          ),
          const SizedBox(height: AppSpacing.s12),
          Material(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(AppRadius.r16),
            clipBehavior: Clip.antiAlias,
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final mutedTextColor = isDark
        ? AppColors.darkTextMuted
        : AppColors.lightTextMuted;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s8,
      ),
      leading: Icon(icon, color: primaryTextColor),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(color: primaryTextColor),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(color: secondaryTextColor),
      ),
      trailing: Icon(Icons.chevron_right, color: mutedTextColor),
      onTap: onTap,
    );
  }
}
