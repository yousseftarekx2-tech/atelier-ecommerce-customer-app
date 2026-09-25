import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/cart/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../home/presentation/widgets/home_header.dart';
import '../../data/look_mock_data.dart';
import '../../domain/entities/look.dart';

class LooksScreen extends StatefulWidget {
  const LooksScreen({super.key});

  @override
  State<LooksScreen> createState() => _LooksScreenState();
}

class _LooksScreenState extends State<LooksScreen> {
  static const List<String> _filters = [
    'All',
    'Minimal',
    'Street',
    'Casual',
    'Classic',
    'Bold',
    'Active',
  ];

  String _selectedFilter = 'All';

  List<Look> get _filteredLooks {
    if (_selectedFilter == 'All') {
      return LookMockData.looks;
    }

    return LookMockData.looks
        .where(
          (look) => look.tag.toLowerCase() == _selectedFilter.toLowerCase(),
        )
        .toList();
  }

  void _openLookDetails(BuildContext context, String lookId) {
    context.push(Routes.lookDetailsPath(lookId));
  }

  String _localizedFilter(AppLocalizations l10n, String filter) {
    switch (filter) {
      case 'Minimal':
        return l10n.lookFilterMinimal;
      case 'Street':
        return l10n.lookFilterStreet;
      case 'Casual':
        return l10n.lookFilterCasual;
      case 'Classic':
        return l10n.lookFilterClassic;
      case 'Bold':
        return l10n.lookFilterBold;
      case 'Active':
        return l10n.lookFilterActive;
      default:
        return l10n.lookFilterAll;
    }
  }

  String _localizedDescription(AppLocalizations l10n, Look look) {
    switch (look.id) {
      case 'light-after-dark':
        return l10n.lookLightAfterDarkDescription;
      case 'city-static':
        return l10n.lookCityStaticDescription;
      case 'off-duty':
        return l10n.lookOffDutyDescription;
      case 'after-hours':
        return l10n.lookAfterHoursDescription;
      default:
        return look.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final topSafeArea = MediaQuery.paddingOf(context).top;
    final headerHeight = topSafeArea + 56;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: headerHeight)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s20,
                    AppSpacing.s16,
                    AppSpacing.s20,
                    0,
                  ),
                  child: _buildIntro(l10n),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.s24,
                    bottom: AppSpacing.s24,
                  ),
                  child: _buildFilters(l10n),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                sliver: SliverList.separated(
                  itemCount: _filteredLooks.length,
                  itemBuilder: (context, index) {
                    final look = _filteredLooks[index];

                    return _LookCard(
                      look: look,
                      description: _localizedDescription(l10n, look),
                      piecesLabel: l10n.lookPieces(look.products.length),
                      onTap: () => _openLookDetails(context, look.id),
                    );
                  },
                  separatorBuilder: (_, _) {
                    return const Gap(AppSpacing.s32);
                  },
                ),
              ),
              const SliverToBoxAdapter(child: Gap(AppSpacing.s40)),
            ],
          ),
          SafeArea(
            bottom: false,
            child: BlocSelector<CartCubit, CartState, int>(
              selector: (state) => state.itemCount,
              builder: (context, cartItemCount) {
                return HomeHeader(
                  cartItemCount: cartItemCount,
                  onNotificationsPressed: () {},
                  onCartPressed: () => context.push(Routes.cart),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.looksEyebrow,
          style: AppTextStyles.labelMedium.copyWith(letterSpacing: 2),
        ),
        const Gap(AppSpacing.s8),
        Text(l10n.looksTitle, style: AppTextStyles.displayMedium),
        const Gap(AppSpacing.s8),
        Text(l10n.looksSubtitle, style: AppTextStyles.bodyMedium),
      ],
    );
  }

  Widget _buildFilters(AppLocalizations l10n) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) {
          return const Gap(AppSpacing.s8);
        },
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final selected = filter == _selectedFilter;

          return ChoiceChip(
            label: Text(_localizedFilter(l10n, filter)),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedFilter = filter;
              });
            },
            showCheckmark: false,
            labelStyle: AppTextStyles.labelMedium.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          );
        },
      ),
    );
  }
}

class _LookCard extends StatelessWidget {
  const _LookCard({
    required this.look,
    required this.description,
    required this.piecesLabel,
    required this.onTap,
  });

  final Look look;
  final String description;
  final String piecesLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(look.heroImage, fit: BoxFit.cover),
                  Positioned(
                    top: AppSpacing.s16,
                    right: AppSpacing.s16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s8,
                        vertical: AppSpacing.s4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        piecesLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppSpacing.s16),
          Text(
            look.title,
            style: AppTextStyles.headingSmall.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const Gap(AppSpacing.s4),
          Text(
            look.tag,
            style: AppTextStyles.labelSmall.copyWith(letterSpacing: 1.4),
          ),
          const Gap(AppSpacing.s8),
          Text(description, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
