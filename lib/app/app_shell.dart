import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _AtelierBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

class _AtelierBottomNavigationBar extends StatelessWidget {
  const _AtelierBottomNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _items = [
    _NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    _NavigationItem(
      label: 'Shop',
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
    ),
    _NavigationItem(
      label: 'Looks',
      icon: Icons.style_outlined,
      activeIcon: Icons.style,
    ),
    _NavigationItem(
      label: 'Favorites',
      icon: Icons.favorite_border,
      activeIcon: Icons.favorite,
    ),
    _NavigationItem(
      label: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.brightness == Brightness.light
                  ? AppColors.lightDivider
                  : AppColors.darkDivider,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s8,
            vertical: AppSpacing.s8,
          ),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => onDestinationSelected(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.s4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          size: 22,
                          color: isSelected
                              ? colorScheme.onSurface
                              : colorScheme.onSurface.withValues(alpha: 0.55),
                        ),
                        const SizedBox(height: AppSpacing.s4),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? colorScheme.onSurface
                                : colorScheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
