import 'package:atelier_customer/features/settings/cubit/settings_cubit.dart';
import 'package:atelier_customer/features/settings/data/datasource/settings_local_data_source.dart';
import 'package:atelier_customer/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:atelier_customer/features/style/cubit/style_cubit.dart';
import 'package:atelier_customer/features/style/data/datasource/style_remote_data_source.dart';
import 'package:atelier_customer/features/style/data/repositories/style_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'features/address/cubit/address_cubit.dart';
import 'features/address/data/datasource/address_remote_data_source.dart';
import 'features/address/data/repositories/address_repository_impl.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/favorites/cubit/favorites_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/notifications/cubit/notifications_cubit.dart';
import 'features/notifications/data/datasource/notifications_remote_data_source.dart';
import 'features/notifications/data/repositories/notifications_repository_impl.dart';
import 'features/orders/data/datasource/orders_remote_data_source.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/recently_viewed/cubit/recently_viewed_cubit.dart';
import 'features/recently_viewed/data/datasource/recently_viewed_local_data_source.dart';
import 'features/recently_viewed/data/repositories/recently_viewed_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    publishableKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  final supabase = Supabase.instance.client;

  final authRemoteDataSource = AuthRemoteDataSource(supabase);

  final authRepository = AuthRepositoryImpl(authRemoteDataSource);

  final authCubit = AuthCubit(authRepository);

  final productRepository = ProductRepositoryImpl();

  final styleRemoteDataSource = StyleRemoteDataSource(supabase);

  final styleRepository = StyleRepositoryImpl(styleRemoteDataSource);

  final styleCubit = StyleCubit(styleRepository);

  final addressRemoteDataSource = AddressRemoteDataSource(supabase);

  final addressRepository = AddressRepositoryImpl(addressRemoteDataSource);

  final addressCubit = AddressCubit(addressRepository);

  await addressCubit.loadAddresses();

  final notificationsRemoteDataSource = NotificationsRemoteDataSource(supabase);

  final notificationsRepository = NotificationsRepositoryImpl(
    notificationsRemoteDataSource,
  );

  final notificationsCubit = NotificationsCubit(notificationsRepository);

  final ordersRemoteDataSource = OrdersRemoteDataSource(supabase);

  final ordersRepository = OrdersRepositoryImpl(ordersRemoteDataSource);

  final prefs = await SharedPreferences.getInstance();

  final settingsLocalDataSource = SettingsLocalDataSource(prefs);

  final settingsRepository = SettingsRepositoryImpl(settingsLocalDataSource);

  final settingsCubit = SettingsCubit(settingsRepository);

  settingsCubit.loadSettings();

  final recentlyViewedDataSource = RecentlyViewedLocalDataSource(prefs);

  final recentlyViewedRepository = RecentlyViewedRepositoryImpl(
    recentlyViewedDataSource,
  );

  final recentlyViewedCubit = RecentlyViewedCubit(recentlyViewedRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => FavoritesCubit()),
        BlocProvider.value(value: recentlyViewedCubit),
        BlocProvider.value(value: addressCubit),
        BlocProvider.value(value: notificationsCubit),
        BlocProvider(create: (_) => HomeCubit(productRepository)..loadHome()),
        BlocProvider.value(value: settingsCubit),
      ],
      child: AtelierApp(
        styleCubit: styleCubit,
        ordersRepository: ordersRepository,
      ),
    ),
  );
}
