import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/routing/app_router.dart';
import '../core/routing/routes.dart';
import '../core/theme/app_theme.dart';

class AtelierApp extends StatefulWidget {
  const AtelierApp({super.key});

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
    return MaterialApp.router(
      title: 'ATELIER',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
