import 'dart:async';

import 'package:atelier_customer/L10n/app_localizations.dart';
import 'package:atelier_customer/features/orders/cubit/oeder_cubit.dart';
import 'package:atelier_customer/features/settings/cubit/settings_cubit.dart';
import 'package:atelier_customer/features/settings/cubit/settings_state.dart';
import 'package:atelier_customer/features/style/cubit/style_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/routing/app_router.dart';
import '../core/routing/routes.dart';
import '../core/theme/app_theme.dart';

class AtelierApp extends StatefulWidget {
  const AtelierApp({super.key, required this.styleCubit});

  final StyleCubit styleCubit;

  @override
  State<AtelierApp> createState() => _AtelierAppState();
}

class _AtelierAppState extends State<AtelierApp> {
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _listenToAuthStateChanges();
  }

  void _listenToAuthStateChanges() {
    final auth = Supabase.instance.client.auth;

    _authStateSubscription = auth.onAuthStateChange.listen((authState) {
      if (authState.event == AuthChangeEvent.passwordRecovery) {
        AppRouter.router.go(Routes.resetPassword);
      }
    }, onError: (_) {});
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrdersCubit()),
        BlocProvider.value(value: widget.styleCubit),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'ATELIER',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: switch (state.appearance) {
              AppAppearance.system => ThemeMode.system,
              AppAppearance.light => ThemeMode.light,
              AppAppearance.dark => ThemeMode.dark,
            },
            locale: switch (state.language) {
              AppLanguage.english => const Locale('en'),
              AppLanguage.arabic => const Locale('ar'),
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
