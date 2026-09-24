import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _openSupportEmail(
    BuildContext context, {
    required String subject,
    required String body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@atelier.app',
      queryParameters: {'subject': subject, 'body': body},
    );

    final launched = await launchUrl(uri);

    if (!launched && context.mounted) {
      final l10n = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.helpSupportEmailUnavailable)));
    }
  }

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
                      l10n.helpSupportTitle,
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
                      l10n.helpSupportIntro,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _SectionLabel(title: l10n.helpSupportContactTitle),
                    const SizedBox(height: AppSpacing.s12),
                    _SupportTile(
                      icon: Icons.email_outlined,
                      title: l10n.helpSupportContact,
                      subtitle: l10n.helpSupportContactSubtitle,
                      onTap: () {
                        _openSupportEmail(
                          context,
                          subject: l10n.helpSupportEmailSubject,
                          body: l10n.helpSupportEmailBody,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _SectionLabel(title: l10n.helpSupportFaqTitle),
                    const SizedBox(height: AppSpacing.s12),
                    _FaqTile(
                      question: l10n.helpSupportFaq1Question,
                      answer: l10n.helpSupportFaq1Answer,
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    _FaqTile(
                      question: l10n.helpSupportFaq2Question,
                      answer: l10n.helpSupportFaq2Answer,
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    _FaqTile(
                      question: l10n.helpSupportFaq3Question,
                      answer: l10n.helpSupportFaq3Answer,
                    ),
                    const SizedBox(height: AppSpacing.s28),
                    _SectionLabel(title: l10n.helpSupportProblemTitle),
                    const SizedBox(height: AppSpacing.s12),
                    _SupportTile(
                      icon: Icons.bug_report_outlined,
                      title: l10n.helpSupportReportProblem,
                      subtitle: l10n.helpSupportReportProblemSubtitle,
                      onTap: () {
                        _openSupportEmail(
                          context,
                          subject: l10n.helpSupportProblemSubject,
                          body: l10n.helpSupportProblemBody,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s32),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({
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
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
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
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        childrenPadding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          0,
          AppSpacing.s16,
          AppSpacing.s16,
        ),
        title: Text(
          question,
          style: AppTextStyles.bodyLarge.copyWith(color: colorScheme.onSurface),
        ),
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              answer,
              style: AppTextStyles.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
