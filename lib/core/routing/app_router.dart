import 'package:atelier_customer/features/address/cubit/address_cubit.dart';
import 'package:atelier_customer/features/address/presentation/screens/address_screen.dart';
import 'package:atelier_customer/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:atelier_customer/features/auth/presentation/pages/login_screen.dart';
import 'package:atelier_customer/features/auth/presentation/pages/register_screen.dart';
import 'package:atelier_customer/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:atelier_customer/features/cart/presentation/pages/cart_screen.dart';
import 'package:atelier_customer/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:atelier_customer/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:atelier_customer/features/home/presentation/pages/home_screen.dart';
import 'package:atelier_customer/features/looks/presentation/pages/look_details_screen.dart';
import 'package:atelier_customer/features/looks/presentation/pages/looks_screen.dart';
import 'package:atelier_customer/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:atelier_customer/features/orders/presentation/screens/order_confirmation_screen.dart';
import 'package:atelier_customer/features/orders/presentation/screens/order_details_screen.dart';
import 'package:atelier_customer/features/orders/presentation/screens/orders_screen.dart';
import 'package:atelier_customer/features/products/presentation/pages/product_details_screen.dart';
import 'package:atelier_customer/features/profile/presentation/pages/profile_screen.dart';
import 'package:atelier_customer/features/recently_viewed/presentation/screens/recently_viewed_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/about_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/account_information_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/help_support_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/password_security_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/privacy_data_screen.dart';
import 'package:atelier_customer/features/settings/presentation/screens/settings_screen.dart';
import 'package:atelier_customer/features/shop/presentation/pages/shop_screen.dart';
import 'package:atelier_customer/features/splash/presentation/pages/splash_screen.dart';
import 'package:atelier_customer/features/style/presentation/screens/my_style_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordScreen();
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) {
          return const ResetPasswordScreen();
        },
      ),

      // Product Details
      GoRoute(
        path: Routes.productDetails,
        builder: (context, state) {
          final productId = state.pathParameters['productId'];

          if (productId == null || productId.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Product not found.')),
            );
          }

          return ProductDetailsScreen(productId: productId);
        },
      ),

      // Cart
      GoRoute(
        path: Routes.cart,
        builder: (context, state) {
          return const CartScreen();
        },
      ),

      // Checkout
      GoRoute(
        path: Routes.checkout,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AddressCubit(context.read())..loadAddresses(),
            child: const CheckoutScreen(),
          );
        },
      ),

      // Order Confirmation
      GoRoute(
        path: Routes.orderConfirmation,
        builder: (context, state) {
          return const OrderConfirmationScreen();
        },
      ),

      // Orders
      GoRoute(
        path: Routes.orders,
        builder: (context, state) {
          return const OrdersScreen();
        },
      ),

      // Order Details
      GoRoute(
        path: Routes.orderDetails,
        builder: (context, state) {
          final orderId = state.pathParameters['orderId'];

          if (orderId == null || orderId.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Order not found.')),
            );
          }

          return OrderDetailsScreen(orderId: orderId);
        },
      ),

      // Look Details
      GoRoute(
        path: Routes.lookDetails,
        builder: (context, state) {
          final lookId = state.pathParameters['lookId']!;

          return LookDetailsScreen(lookId: lookId);
        },
      ),

      GoRoute(
        path: Routes.style,
        builder: (context, state) => const MyStyleScreen(),
      ),
      GoRoute(
        path: Routes.view,
        builder: (context, state) => const RecentlyViewedScreen(),
      ),
      GoRoute(
        path: Routes.address,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: Routes.accountInformation,
        builder: (context, state) {
          return const AccountInformationScreen();
        },
      ),
      GoRoute(
        path: Routes.passwordSecurity,
        builder: (context, state) {
          return const PasswordSecurityScreen();
        },
      ),
      GoRoute(
        path: Routes.privacyData,
        builder: (context, state) {
          return const PrivacyDataScreen();
        },
      ),
      GoRoute(
        path: Routes.helpSupport,
        builder: (context, state) {
          return const HelpSupportScreen();
        },
      ),
      GoRoute(
        path: Routes.about,
        builder: (context, state) {
          return const AboutScreen();
        },
      ),
      // Main App Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.shop,
                builder: (context, state) {
                  return const ShopScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.looks,
                builder: (context, state) {
                  return const LooksScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.favorites,
                builder: (context, state) {
                  return const FavoritesScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

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
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: Theme.of(context).colorScheme.surface,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Looks',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
