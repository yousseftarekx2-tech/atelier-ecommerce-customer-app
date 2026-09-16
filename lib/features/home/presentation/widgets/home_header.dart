import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.onNotificationsPressed,
    required this.onCartPressed,
    required this.cartItemCount,
    super.key,
  });

  final VoidCallback onNotificationsPressed;
  final VoidCallback onCartPressed;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(
            color: theme.brightness == Brightness.light
                ? AppColors.lightDivider
                : AppColors.darkDivider,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
        child: Row(
          children: [
            Text(
              'ATELIER',
              style: AppTextStyles.headingSmall.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            _HeaderIconButton(
              icon: Icons.notifications_none_rounded,
              showDot: true,
              onPressed: onNotificationsPressed,
            ),
            const SizedBox(width: AppSpacing.s8),
            _HeaderIconButton(
              icon: Icons.shopping_bag_outlined,
              badge: cartItemCount > 0 ? '$cartItemCount' : null,
              onPressed: onCartPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onPressed,
    this.badge,
    this.showDot = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? badge;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onPressed,
            padding: EdgeInsets.zero,
            icon: Icon(icon, size: 23, color: colorScheme.onSurface),
          ),
          if (showDot)
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (badge != null)
            Positioned(
              top: 1,
              right: -1,
              child: Container(
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: colorScheme.onSurface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  badge!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: colorScheme.surface,
                    fontSize: 9,
                    height: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
