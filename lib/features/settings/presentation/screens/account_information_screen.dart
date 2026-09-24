import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../auth/domain/entities/auth_user.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthCubit>().state;

    final user = state is AuthAuthenticated ? state.user : null;

    _nameController = TextEditingController(text: user?.fullName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          final name = state.user.fullName ?? '';

          if (_nameController.text != name) {
            _nameController.text = name;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(l10n.accountInformationSaved)),
            );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: context.pop,
            icon: Icon(Icons.arrow_back, color: primaryTextColor),
          ),
          title: Text(
            l10n.accountInformationTitle,
            style: AppTextStyles.headingSmall.copyWith(
              color: primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is! AuthAuthenticated) {
              return Center(
                child: Text(
                  l10n.accountInformationUnavailable,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
              );
            }

            return _AccountInformationContent(
              user: state.user,
              controller: _nameController,
              primaryTextColor: primaryTextColor,
              secondaryTextColor: secondaryTextColor,
            );
          },
        ),
      ),
    );
  }
}

class _AccountInformationContent extends StatelessWidget {
  const _AccountInformationContent({
    required this.user,
    required this.controller,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final AuthUser user;
  final TextEditingController controller;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s20,
        AppSpacing.s24,
        AppSpacing.s20,
        AppSpacing.s40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.accountInformationIntro,
            style: AppTextStyles.bodyMedium.copyWith(color: secondaryTextColor),
          ),
          const SizedBox(height: AppSpacing.s32),
          _FieldLabel(
            label: l10n.accountInformationFullName,
            color: secondaryTextColor,
          ),
          const SizedBox(height: AppSpacing.s8),
          TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: l10n.accountInformationFullNameHint,
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _FieldLabel(
            label: l10n.accountInformationEmail,
            color: secondaryTextColor,
          ),
          const SizedBox(height: AppSpacing.s8),
          TextFormField(
            initialValue: user.email,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock_outline, color: secondaryTextColor),
            ),
          ),
          const SizedBox(height: AppSpacing.s32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () {
                context.read<AuthCubit>().updateFullName(
                  fullName: controller.text,
                );
              },
              child: Text(
                l10n.accountInformationSave,
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyles.labelMedium.copyWith(color: color));
  }
}
