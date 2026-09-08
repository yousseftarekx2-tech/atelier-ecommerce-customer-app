import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    publishableKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  final authRemoteDataSource = AuthRemoteDataSource(Supabase.instance.client);

  final authRepository = AuthRepositoryImpl(authRemoteDataSource);

  final authCubit = AuthCubit(authRepository);

  runApp(BlocProvider.value(value: authCubit, child: const AtelierApp()));
}
