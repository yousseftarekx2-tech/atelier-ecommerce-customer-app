import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeShopTheLook extends StatelessWidget {
  const HomeShopTheLook({required this.onShopPressed, super.key});

  final VoidCallback onShopPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/home/shop_the_look.jpg',
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.84),
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
                    l10n.homeShopTheLookEyebrow,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.82),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Text(
                    l10n.homeShopTheLookTitle,
                    style: AppTextStyles.headingLarge.copyWith(
                      color: Colors.white,
                      height: 1.08,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: InkWell(
                      onTap: onShopPressed,
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
                              l10n.homeShop,
                              style: AppTextStyles.button.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s8),
                            const Icon(
                              Icons.open_in_new_rounded,
                              size: 16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
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
