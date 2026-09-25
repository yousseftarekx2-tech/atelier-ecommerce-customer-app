import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/core/routing/routes.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _totalPages = 3;
  static const String _onboardingCompletedKey = 'onboarding_completed';

  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const List<String> _images = [
    'assets/images/onboarding_01.png',
    'assets/images/onboarding_02.png',
    'assets/images/onboarding_03.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    _finishOnboarding();
  }

  void _skip() {
    _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(_onboardingCompletedKey, true);

    if (!mounted) {
      return;
    }

    context.go(Routes.login);
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    const titles = ['Discover your style.', 'More than clothes.'];

    const descriptions = [
      'Find pieces that feel like you.',
      'Discover looks made to be worn together.',
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _totalPages,
        physics: const ClampingScrollPhysics(),
        onPageChanged: _handlePageChanged,
        itemBuilder: (context, index) {
          if (index < 2) {
            return OnboardingContent(
              image: _images[index],
              title: index == 0
                  ? l10n.onboardingDiscoverTitle
                  : l10n.onboardingMoreThanClothesTitle,
              description: index == 0
                  ? l10n.onboardingDiscoverDescription
                  : l10n.onboardingMoreThanClothesDescription,
              pageNumber: index + 1,
              totalPages: _totalPages,
              onNext: _nextPage,
              onSkip: _skip,
            );
          }

          return _FinalOnboardingContent(
            image: _images[index],
            onGetStarted: _finishOnboarding,
            onContinueAsGuest: _finishOnboarding,
          );
        },
      ),
    );
  }
}

class _FinalOnboardingContent extends StatelessWidget {
  const _FinalOnboardingContent({
    required this.image,
    required this.onGetStarted,
    required this.onContinueAsGuest,
  });

  final String image;
  final VoidCallback onGetStarted;
  final VoidCallback onContinueAsGuest;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const foregroundColor = AppColors.lightBackground;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover, alignment: Alignment.center),
        const _FinalGradient(),
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
                Row(
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
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                      child: Text(
                        l10n.onboardingLookIndicator(3, 3),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: foregroundColor.withValues(alpha: 0.80),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 2,
                          width: 28,
                          decoration: BoxDecoration(
                            color: foregroundColor.withValues(alpha: 0.30),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          height: 2,
                          width: 28,
                          decoration: BoxDecoration(
                            color: foregroundColor.withValues(alpha: 0.30),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          height: 2,
                          width: 40,
                          decoration: BoxDecoration(
                            color: foregroundColor,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: foregroundColor.withValues(alpha: 0.60),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Text(
                      l10n.onboardingFinalTitle,
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
                      l10n.onboardingFinalDescription,
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
                        onPressed: onGetStarted,
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
                              l10n.onboardingGetStarted,
                              style: AppTextStyles.button.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s6),
                            const Icon(Icons.arrow_forward, size: 17),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Center(
                      child: TextButton(
                        onPressed: onContinueAsGuest,
                        style: TextButton.styleFrom(
                          foregroundColor: foregroundColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.s8,
                          ),
                        ),
                        child: Text(
                          l10n.onboardingContinueAsGuest,
                          style: AppTextStyles.button.copyWith(
                            color: foregroundColor.withValues(alpha: 0.80),
                            decoration: TextDecoration.underline,
                            decorationColor: foregroundColor.withValues(
                              alpha: 0.30,
                            ),
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FinalGradient extends StatelessWidget {
  const _FinalGradient();

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
