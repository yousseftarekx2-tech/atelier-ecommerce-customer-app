import 'package:atelier_customer/core/theme/app_colors.dart';
import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_spacing.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:atelier_customer/features/style/cubit/style_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/style_preference_options.dart';
import '../../domain/entities/style_preferences.dart';

class MyStyleScreen extends StatelessWidget {
  const MyStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MyStyleView();
  }
}

class _MyStyleView extends StatelessWidget {
  const _MyStyleView();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final surfaceLowColor = isDark
        ? AppColors.darkSurfaceMuted
        : AppColors.lightSurfaceMuted;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: primaryTextColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'ATELIER',
          style: AppTextStyles.labelLarge.copyWith(
            color: primaryTextColor,
            letterSpacing: 1.8,
          ),
        ),
      ),
      body: BlocBuilder<StyleCubit, StylePreferences>(
        builder: (context, preferences) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s20,
                    AppSpacing.s20,
                    AppSpacing.s20,
                    AppSpacing.s40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'MY STYLE',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: secondaryTextColor,
                              letterSpacing: 1.8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s8,
                              vertical: AppSpacing.s3,
                            ),
                            decoration: BoxDecoration(
                              color: surfaceLowColor,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              '${preferences.selectedCount} SELECTED',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: primaryTextColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.s8),

                      Text(
                        'Tell us what feels like you.',
                        style: AppTextStyles.headingLarge.copyWith(
                          color: primaryTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s8),

                      Text(
                        'Your preferences help us personalize what you discover.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: secondaryTextColor,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s32),

                      _PreferenceSection(
                        number: '01',
                        title: 'STYLE',
                        description:
                            'Choose the aesthetics you naturally gravitate toward.',
                        options: StylePreferenceOptions.styles,
                        selectedValues: preferences.styles,
                        onToggle: context.read<StyleCubit>().toggleStyle,
                        surfaceColor: surfaceColor,
                        primaryTextColor: primaryTextColor,
                        borderColor: borderColor,
                        secondaryTextColor: secondaryTextColor,
                        layout: _PreferenceLayout.gridTwo,
                      ),

                      const SizedBox(height: AppSpacing.s32),

                      _PreferenceSection(
                        number: '02',
                        title: 'COLORS',
                        description:
                            'Choose the tones you naturally reach for.',
                        options: StylePreferenceOptions.colors,
                        selectedValues: preferences.colors,
                        onToggle: context.read<StyleCubit>().toggleColor,
                        surfaceColor: surfaceColor,
                        primaryTextColor: primaryTextColor,
                        borderColor: borderColor,
                        secondaryTextColor: secondaryTextColor,
                        layout: _PreferenceLayout.gridTwo,
                        colorDots: const {
                          'Neutral': Color(0xFFD8D4CC),
                          'Dark': Color(0xFF1A1A1A),
                          'Earthy': Color(0xFF7D6B58),
                          'Light': Color(0xFFEFEFE9),
                          'Bold': Color(0xFF8A2B2B),
                          'Pastel': Color(0xFFB8C5D6),
                        },
                      ),

                      const SizedBox(height: AppSpacing.s32),

                      _PreferenceSection(
                        number: '03',
                        title: 'LIFESTYLE',
                        description: 'What do you dress for most?',
                        options: StylePreferenceOptions.lifestyles,
                        selectedValues: preferences.lifestyles,
                        onToggle: context.read<StyleCubit>().toggleLifestyle,
                        surfaceColor: surfaceColor,
                        primaryTextColor: primaryTextColor,
                        borderColor: borderColor,
                        secondaryTextColor: secondaryTextColor,
                        layout: _PreferenceLayout.pills,
                      ),

                      const SizedBox(height: AppSpacing.s32),

                      _PreferenceSection(
                        number: '04',
                        title: 'FIT',
                        description: 'Choose the silhouettes you prefer.',
                        options: StylePreferenceOptions.fits,
                        selectedValues: preferences.fits,
                        onToggle: context.read<StyleCubit>().toggleFit,
                        surfaceColor: surfaceColor,
                        primaryTextColor: primaryTextColor,
                        borderColor: borderColor,
                        secondaryTextColor: secondaryTextColor,
                        layout: _PreferenceLayout.gridThree,
                      ),
                    ],
                  ),
                ),
              ),

              _BottomActions(
                backgroundColor: backgroundColor,
                primaryTextColor: primaryTextColor,
                borderColor: borderColor,
              ),
            ],
          );
        },
      ),
    );
  }
}

enum _PreferenceLayout { gridTwo, pills, gridThree }

class _PreferenceSection extends StatelessWidget {
  const _PreferenceSection({
    required this.number,
    required this.title,
    required this.description,
    required this.options,
    required this.selectedValues,
    required this.onToggle,
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.borderColor,
    required this.secondaryTextColor,
    required this.layout,
    this.colorDots,
  });

  final String number;
  final String title;
  final String description;
  final List<String> options;
  final Set<String> selectedValues;
  final ValueChanged<String> onToggle;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color borderColor;
  final Color secondaryTextColor;
  final _PreferenceLayout layout;
  final Map<String, Color>? colorDots;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$number / ',
              style: AppTextStyles.labelLarge.copyWith(
                color: secondaryTextColor,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              title,
              style: AppTextStyles.labelLarge.copyWith(
                color: primaryTextColor,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.s4),

        Text(
          description,
          style: AppTextStyles.bodySmall.copyWith(color: secondaryTextColor),
        ),

        const SizedBox(height: AppSpacing.s16),

        if (layout == _PreferenceLayout.gridTwo) _buildTwoColumnGrid(),

        if (layout == _PreferenceLayout.gridThree) _buildThreeColumnGrid(),

        if (layout == _PreferenceLayout.pills) _buildPills(),
      ],
    );
  }

  Widget _buildTwoColumnGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.s12,
        mainAxisSpacing: AppSpacing.s12,
        mainAxisExtent: 48,
      ),
      itemBuilder: (context, index) {
        final option = options[index];

        return _GridPreferenceChip(
          label: option,
          selected: selectedValues.contains(option),
          onTap: () => onToggle(option),
          surfaceColor: surfaceColor,
          primaryTextColor: primaryTextColor,
          borderColor: borderColor,
          secondaryTextColor: secondaryTextColor,
          colorDot: colorDots?[option],
        );
      },
    );
  }

  Widget _buildThreeColumnGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.s8,
        mainAxisSpacing: AppSpacing.s8,
        mainAxisExtent: 48,
      ),
      itemBuilder: (context, index) {
        final option = options[index];

        return _FitPreferenceChip(
          label: option,
          selected: selectedValues.contains(option),
          onTap: () => onToggle(option),
          surfaceColor: surfaceColor,
          primaryTextColor: primaryTextColor,
          borderColor: borderColor,
          secondaryTextColor: secondaryTextColor,
        );
      },
    );
  }

  Widget _buildPills() {
    return Wrap(
      spacing: AppSpacing.s8,
      runSpacing: AppSpacing.s8,
      children: options.map((option) {
        return _LifestylePreferenceChip(
          label: option,
          selected: selectedValues.contains(option),
          onTap: () => onToggle(option),
          surfaceColor: surfaceColor,
          primaryTextColor: primaryTextColor,
          borderColor: borderColor,
          secondaryTextColor: secondaryTextColor,
        );
      }).toList(),
    );
  }
}

class _GridPreferenceChip extends StatelessWidget {
  const _GridPreferenceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.borderColor,
    required this.secondaryTextColor,
    this.colorDot,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color borderColor;
  final Color secondaryTextColor;
  final Color? colorDot;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? primaryTextColor : surfaceColor;

    final foregroundColor = selected
        ? (Theme.of(context).brightness == Brightness.dark
              ? AppColors.black
              : AppColors.white)
        : secondaryTextColor;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r12),
            border: Border.all(
              color: selected ? primaryTextColor : borderColor,
            ),
          ),
          child: Row(
            children: [
              if (colorDot != null) ...[
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: colorDot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.s8),
              ],
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: foregroundColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, size: 18, color: foregroundColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _FitPreferenceChip extends StatelessWidget {
  const _FitPreferenceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.borderColor,
    required this.secondaryTextColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color borderColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? primaryTextColor : surfaceColor;

    final foregroundColor = selected
        ? (Theme.of(context).brightness == Brightness.dark
              ? AppColors.black
              : AppColors.white)
        : secondaryTextColor;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r12),
            border: Border.all(
              color: selected ? primaryTextColor : borderColor,
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelMedium.copyWith(
              color: foregroundColor,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _LifestylePreferenceChip extends StatelessWidget {
  const _LifestylePreferenceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.surfaceColor,
    required this.primaryTextColor,
    required this.borderColor,
    required this.secondaryTextColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color surfaceColor;
  final Color primaryTextColor;
  final Color borderColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? primaryTextColor : surfaceColor;

    final foregroundColor = selected
        ? (Theme.of(context).brightness == Brightness.dark
              ? AppColors.black
              : AppColors.white)
        : secondaryTextColor;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected ? primaryTextColor : borderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: foregroundColor,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: AppSpacing.s6),
                Icon(Icons.check, size: 16, color: foregroundColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color primaryTextColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s12,
        AppSpacing.s20,
        AppSpacing.s20,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  await context.read<StyleCubit>().reset();
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkSurfaceMuted
                      : AppColors.lightSurfaceMuted,
                  foregroundColor: primaryTextColor,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                ),
                child: Text(
                  'RESET',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: primaryTextColor,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s8),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<StyleCubit>().savePreferences();

                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('PREFERENCES SAVED')),
                      );
                  } catch (_) {
                    if (!context.mounted) {
                      return;
                    }

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('FAILED TO SAVE PREFERENCES'),
                        ),
                      );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r12),
                  ),
                ),
                child: Text(
                  'SAVE PREFERENCES',
                  style: AppTextStyles.labelMedium.copyWith(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
