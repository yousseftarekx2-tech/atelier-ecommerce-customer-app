import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({required this.onExplorePressed, super.key});

  final VoidCallback onExplorePressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/home/hero.jpg', fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.82),
                  ],
                  stops: const [0.38, 1],
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.s20,
              right: AppSpacing.s20,
              bottom: AppSpacing.s20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DROP 01 — AFTER DARK',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Text(
                    'New pieces for\nafter-hours.',
                    style: AppTextStyles.displayMedium.copyWith(
                      color: Colors.white,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  _HeroButton(
                    onPressed: onExplorePressed,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroButton extends StatelessWidget {
  const _HeroButton({required this.onPressed, required this.colorScheme});

  final VoidCallback onPressed;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Explore Drop',
                style: AppTextStyles.button.copyWith(color: Colors.black),
              ),
              const SizedBox(width: AppSpacing.s8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 17,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
