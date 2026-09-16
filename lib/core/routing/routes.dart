abstract final class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  // static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';

  static const String home = '/home';
  static const String shop = '/shop';
  static const String looks = '/looks';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String cart = '/cart';

  static const String productDetails = '/product/:productId';

  static String productDetailsPath(String productId) {
    return '/product/$productId';
  }
}