abstract final class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  static const String home = '/home';
  static const String shop = '/shop';
  static const String looks = '/looks';
  static const String lookDetails = '/looks/:lookId';

  static String lookDetailsPath(String lookId) {
    return '/looks/$lookId';
  }

  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static const String settings = '/profile/settings';
  static const String accountInformation = '/profile/settings/account';
  static const String passwordSecurity = '/profile/settings/password-security';
  static const String privacyData = '/profile/settings/privacy-data';
  static const String helpSupport = '/profile/settings/help-support';
  static const String about = '/profile/settings/about';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderConfirmation = '/order-confirmation';
  static const String orders = '/orders';
  static const String style = '/style';
  static const String view = '/view';
  static const String address = '/address';

  static const String orderDetails = '/orders/:orderId';

  static String orderDetailsPath(String orderId) {
    return '/orders/$orderId';
  }

  static const String productDetails = '/product/:productId';

  static String productDetailsPath(String productId) {
    return '/product/$productId';
  }
}
