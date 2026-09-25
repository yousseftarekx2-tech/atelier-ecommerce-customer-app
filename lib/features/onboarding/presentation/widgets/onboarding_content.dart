import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.pageNumber,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  final String image;
  final String title;
  final String description;
  final int pageNumber;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = AppColors.lightBackground;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover, alignment: Alignment.center),
        const _OnboardingGradient(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s24,
              AppSpacing.s20,
              AppSpacing.s24,
              AppSpacing.s28,
            ),
            child: Column(
              children: [
                _TopBar(
                  pageNumber: pageNumber,
                  totalPages: totalPages,
                  foregroundColor: foregroundColor,
                  onSkip: onSkip,
                ),
                const Spacer(),
                _BottomContent(
                  title: title,
                  description: description,
                  pageNumber: pageNumber,
                  totalPages: totalPages,
                  foregroundColor: foregroundColor,
                  onNext: onNext,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingGradient extends StatelessWidget {
  const _OnboardingGradient();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.60),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.90),
              ],
              stops: const [0.0, 0.42, 1.0],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.65,
            widthFactor: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.pageNumber,
    required this.totalPages,
    required this.foregroundColor,
    required this.onSkip,
  });

  final int pageNumber;
  final int totalPages;
  final Color foregroundColor;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Text(
          'ATELIER',
          style: AppTextStyles.labelLarge.copyWith(
            color: foregroundColor,
            letterSpacing: 2.2,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s9,
            vertical: AppSpacing.s6,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(AppSpacing.s12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Text(
            l10n.onboardingLookIndicator(pageNumber, totalPages),
            style: AppTextStyles.labelSmall.copyWith(
              color: foregroundColor.withValues(alpha: 0.80),
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s16),
        TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            l10n.onboardingSkip,
            style: AppTextStyles.labelSmall.copyWith(
              color: foregroundColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomContent extends StatelessWidget {
  const _BottomContent({
    required this.title,
    required this.description,
    required this.pageNumber,
    required this.totalPages,
    required this.foregroundColor,
    required this.onNext,
  });

  final String title;
  final String description;
  final int pageNumber;
  final int totalPages;
  final Color foregroundColor;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProgressIndicator(
          pageNumber: pageNumber,
          totalPages: totalPages,
          foregroundColor: foregroundColor,
        ),
        const SizedBox(height: AppSpacing.s20),
        Text(
          title,
          style: AppTextStyles.displayMedium.copyWith(
            color: foregroundColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
            height: 1.12,
            letterSpacing: -1.28,
          ),
        ),
        const SizedBox(height: AppSpacing.s10),
        Text(
          description,
          style: AppTextStyles.bodyLarge.copyWith(
            color: foregroundColor.withValues(alpha: 0.72),
            fontSize: 15,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.s28),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: foregroundColor,
              foregroundColor: AppColors.black,
              elevation: 0,
              shape: const StadiumBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.onboardingNext,
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.black,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: AppSpacing.s6),
                const Icon(Icons.arrow_forward, size: 17),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.pageNumber,
    required this.totalPages,
    required this.foregroundColor,
  });

  final int pageNumber;
  final int totalPages;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalPages, (index) {
        final isActive = index == pageNumber - 1;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: 2,
          width: isActive ? 40 : 28,
          margin: EdgeInsets.only(right: index == totalPages - 1 ? 0 : 6),
          decoration: BoxDecoration(
            color: isActive
                ? foregroundColor
                : foregroundColor.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
