import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeArchiveCta extends StatelessWidget {
  const HomeArchiveCta({required this.onExplorePressed, super.key});

  final VoidCallback onExplorePressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Column(
        children: [
          Text(
            l10n.homeArchiveEyebrow,
            style: AppTextStyles.labelSmall.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.55),
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.s12),
          Text(
            l10n.homeArchiveTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.headingLarge.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(
            l10n.homeArchiveDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.58),
            ),
          ),
          const SizedBox(height: AppSpacing.s20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: onExplorePressed,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.onSurface,
                foregroundColor: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.homeExploreAll,
                    style: AppTextStyles.button.copyWith(
                      color: colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: colorScheme.surface,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
