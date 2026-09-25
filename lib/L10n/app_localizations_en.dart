// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get settingsSubtitle => 'Make ATELIER work your way.';

  @override
  String get settingsPreferences => 'PREFERENCES';

  @override
  String get settingsAccount => 'ACCOUNT';

  @override
  String get settingsPrivacy => 'PRIVACY';

  @override
  String get settingsSupport => 'SUPPORT';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceSubtitle => 'Choose how ATELIER looks.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'English or Arabic';

  @override
  String get settingsAccountInformation => 'Account Information';

  @override
  String get settingsAccountInformationSubtitle =>
      'Manage your account details';

  @override
  String get settingsPasswordSecurity => 'Password & Security';

  @override
  String get settingsPasswordSecuritySubtitle =>
      'Manage your password and security';

  @override
  String get settingsPrivacyData => 'Privacy & Data';

  @override
  String get settingsPrivacyDataSubtitle => 'Manage your privacy preferences';

  @override
  String get settingsHelpSupport => 'Help & Support';

  @override
  String get settingsHelpSupportSubtitle => 'Get help with ATELIER';

  @override
  String get settingsAbout => 'About ATELIER';

  @override
  String get settingsAboutSubtitle => 'App information and version';

  @override
  String get appearanceSystem => 'System';

  @override
  String get appearanceLight => 'Light';

  @override
  String get appearanceDark => 'Dark';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get aboutLegalese => '© 2026 ATELIER';

  @override
  String get accountInformationTitle => 'Account Information';

  @override
  String get accountInformationIntro =>
      'Manage the personal information associated with your ATELIER account.';

  @override
  String get accountInformationFullName => 'Full Name';

  @override
  String get accountInformationFullNameHint => 'Enter your full name';

  @override
  String get accountInformationEmail => 'Email';

  @override
  String get accountInformationSave => 'SAVE CHANGES';

  @override
  String get accountInformationSaved =>
      'Your account information has been updated.';

  @override
  String get accountInformationUnavailable =>
      'Account information is unavailable.';

  @override
  String get passwordSecurityTitle => 'Password & Security';

  @override
  String get passwordSecurityIntro =>
      'Keep your ATELIER account secure by updating your password.';

  @override
  String get passwordSecurityNewPassword => 'New Password';

  @override
  String get passwordSecurityNewPasswordHint => 'Enter your new password';

  @override
  String get passwordSecurityConfirmPassword => 'Confirm Password';

  @override
  String get passwordSecurityConfirmPasswordHint =>
      'Re-enter your new password';

  @override
  String get passwordSecurityPasswordHint =>
      'Use a strong password that you do not use elsewhere.';

  @override
  String get passwordSecuritySave => 'SAVE PASSWORD';

  @override
  String get passwordSecurityUpdated => 'Your password has been updated.';

  @override
  String get passwordSecurityFieldsRequired =>
      'Please fill in both password fields.';

  @override
  String get passwordSecurityMismatch => 'Passwords do not match.';

  @override
  String get passwordSecurityMinimumLength =>
      'Password must be at least 6 characters.';

  @override
  String get privacyDataTitle => 'Privacy & Data';

  @override
  String get privacyDataIntro =>
      'Manage the data ATELIER stores locally and understand how your account information is used.';

  @override
  String get privacyLocalDataTitle => 'LOCAL DATA';

  @override
  String get privacyLocalDataDescription =>
      'Some app preferences and recently viewed products are stored locally on your device.';

  @override
  String get privacyRecentlyViewed => 'Recently Viewed';

  @override
  String privacyRecentlyViewedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products saved',
      one: '1 product saved',
      zero: 'No products saved',
    );
    return '$_temp0';
  }

  @override
  String get privacyLoading => 'Loading...';

  @override
  String get privacyClearRecentlyViewedTitle => 'Clear Recently Viewed?';

  @override
  String get privacyClearRecentlyViewedMessage =>
      'This will remove all recently viewed products from this device.';

  @override
  String get privacyCancel => 'CANCEL';

  @override
  String get privacyClear => 'CLEAR';

  @override
  String get privacyRecentlyViewedCleared =>
      'Recently viewed products have been cleared.';

  @override
  String get privacyAccountDataTitle => 'ACCOUNT DATA';

  @override
  String get privacyAccountDataDescription =>
      'Your account information is managed securely through your ATELIER account.';

  @override
  String get privacyAccountData => 'Account Information';

  @override
  String get privacyAccountDataSubtitle =>
      'Your name and email are associated with your account.';

  @override
  String get helpSupportTitle => 'Help & Support';

  @override
  String get helpSupportIntro =>
      'Find answers or contact the ATELIER support team.';

  @override
  String get helpSupportContactTitle => 'CONTACT';

  @override
  String get helpSupportContact => 'Contact Support';

  @override
  String get helpSupportContactSubtitle =>
      'Send us an email and we\'ll get back to you.';

  @override
  String get helpSupportFaqTitle => 'FAQ';

  @override
  String get helpSupportFaq1Question => 'How can I change my password?';

  @override
  String get helpSupportFaq1Answer =>
      'Open Settings, choose Password & Security, then enter and confirm your new password.';

  @override
  String get helpSupportFaq2Question => 'How can I change my language?';

  @override
  String get helpSupportFaq2Answer =>
      'Open Settings, choose Language, then select English or Arabic.';

  @override
  String get helpSupportFaq3Question =>
      'How can I clear recently viewed products?';

  @override
  String get helpSupportFaq3Answer =>
      'Open Settings, choose Privacy & Data, then select Recently Viewed and clear the saved products.';

  @override
  String get helpSupportProblemTitle => 'PROBLEM';

  @override
  String get helpSupportReportProblem => 'Report a Problem';

  @override
  String get helpSupportReportProblemSubtitle =>
      'Tell us if something isn\'t working as expected.';

  @override
  String get helpSupportEmailSubject => 'ATELIER Support Request';

  @override
  String get helpSupportEmailBody =>
      'Hi ATELIER Support,\n\nI need help with:\n\n';

  @override
  String get helpSupportProblemSubject => 'ATELIER Problem Report';

  @override
  String get helpSupportProblemBody =>
      'Hi ATELIER Support,\n\nI found a problem in the ATELIER app:\n\n';

  @override
  String get helpSupportEmailUnavailable => 'Unable to open the email app.';

  @override
  String get aboutTitle => 'About ATELIER';

  @override
  String get aboutDescription =>
      'A modern fashion experience built around discovery, style, and simplicity.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get aboutCopyright => 'Copyright';

  @override
  String get aboutPrivacy => 'Privacy & Data';

  @override
  String get aboutSupport => 'Help & Support';

  @override
  String get aboutMadeFor =>
      'Designed and built with care for the ATELIER experience.';

  @override
  String get homeFeatured => 'FEATURED';

  @override
  String get homePickedForYou => 'Picked for you';

  @override
  String get homePickedForYouDescription => 'Pieces that match your style.';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeTrendingNow => 'Trending now';

  @override
  String get homeNewArrivals => 'New arrivals';

  @override
  String get homeNewArrivalsDescription => 'Fresh pieces, just in.';

  @override
  String get homeExploreCollections => 'Explore collections';

  @override
  String get homeNoPiecesFound => 'No pieces found';

  @override
  String get homeTryAnotherSearch => 'Try another search.';

  @override
  String get homeSearchResults => 'Search results';

  @override
  String get homeSearchHint => 'Search pieces, styles, colors...';

  @override
  String get homeHeroEyebrow => 'DROP 01 — AFTER DARK';

  @override
  String get homeHeroTitle => 'New pieces for\nafter-hours.';

  @override
  String get homeExploreDrop => 'Explore Drop';

  @override
  String get homeShopTheLookEyebrow => 'LIGHT AFTER DARK';

  @override
  String get homeShopTheLookTitle => 'Oversized Tee +\nBaggy Jeans + Bomber';

  @override
  String get homeShop => 'Shop';

  @override
  String get homeArchiveEyebrow => 'ATELIER ARCHIVE';

  @override
  String get homeArchiveTitle => 'Made to match you.';

  @override
  String get homeArchiveDescription =>
      'Discover pieces, looks, and styles that feel like yours.';

  @override
  String get homeExploreAll => 'Explore all';

  @override
  String cartItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Your Bag ($count items)',
      one: 'Your Bag (1 item)',
      zero: 'Your Bag (0)',
    );
    return '$_temp0';
  }

  @override
  String get cartDeliveryUnlockedTitle => 'Complimentary Delivery';

  @override
  String get cartDeliveryAvailableTitle => 'Free Delivery Available';

  @override
  String get cartFreeStandardShipping => 'Free standard shipping on your order';

  @override
  String cartAddToFreeDelivery(String amount) {
    return 'Add EGP $amount to unlock free delivery';
  }

  @override
  String get cartUnlocked => 'Unlocked';

  @override
  String get cartItems => 'Cart Items';

  @override
  String get cartPricesInclVat => 'Prices incl. VAT';

  @override
  String get cartPromoCode => 'Promo code';

  @override
  String get cartApply => 'Apply';

  @override
  String get cartSummary => 'SUMMARY';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartEstimatedShipping => 'Estimated shipping';

  @override
  String get cartFree => 'FREE';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartTaxesIncluded => 'Taxes included where applicable.';

  @override
  String get cartSecureCheckout => 'Secure Checkout';

  @override
  String get cartFreeReturns => '14-Day Free Returns';

  @override
  String get cartEmptyTitle => 'Your bag is empty';

  @override
  String get cartEmptyDescription => 'Discover pieces made for after-hours.';

  @override
  String get cartContinueShopping => 'Continue Shopping';

  @override
  String get cartExploreCategories => 'EXPLORE CATEGORIES';

  @override
  String get cartCategoryOvershirts => 'Overshirts';

  @override
  String get cartCategoryWidePants => 'Wide Pants';

  @override
  String get cartCategoryBoxyTees => 'Boxy Tees';

  @override
  String get cartTotalBag => 'TOTAL BAG';

  @override
  String get cartProceedToCheckout => 'Proceed to Checkout';

  @override
  String get cartProductUnavailable => 'This product is no longer available.';

  @override
  String cartSize(String size) {
    return 'Size $size';
  }

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get checkoutEmptyBag => 'Your bag is empty';

  @override
  String get checkoutCompleteOrder => 'Complete your order';

  @override
  String checkoutItemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items in your bag',
      one: '1 item in your bag',
      zero: 'No items in your bag',
    );
    return '$_temp0';
  }

  @override
  String get checkoutContact => 'Contact';

  @override
  String get checkoutAccountUnavailable =>
      'Account information is unavailable.';

  @override
  String get checkoutPhoneOptional => 'Phone Number';

  @override
  String get checkoutPhoneHint => 'Enter your phone number';

  @override
  String get checkoutShippingAddress => 'Shipping Address';

  @override
  String get checkoutNoAddress => 'No delivery address selected.';

  @override
  String get checkoutChange => 'Change';

  @override
  String get checkoutShippingMethod => 'Shipping Method';

  @override
  String get shippingStandard => 'Standard Delivery';

  @override
  String get shippingStandardDescription => '3–5 business days';

  @override
  String get shippingExpress => 'Express Delivery';

  @override
  String get shippingExpressDescription => '1–2 business days';

  @override
  String get checkoutFree => 'Free';

  @override
  String get checkoutPayment => 'Payment';

  @override
  String get checkoutCod => 'Cash on Delivery';

  @override
  String get checkoutCodSubtitle => 'Pay when your order arrives';

  @override
  String get checkoutCard => 'Card Payment';

  @override
  String get checkoutCardSubtitle => 'Credit or debit card';

  @override
  String get checkoutComingSoon => 'Coming Soon';

  @override
  String get checkoutOrderSummary => 'Order Summary';

  @override
  String get checkoutSubtotal => 'Subtotal';

  @override
  String get checkoutTotal => 'Total';

  @override
  String get checkoutPlaceOrder => 'Place Order';

  @override
  String get checkoutSignInRequired =>
      'Please sign in before placing your order';

  @override
  String get checkoutAddressRequired => 'Please select a shipping address';

  @override
  String get checkoutBagEmpty => 'Your bag is empty';

  @override
  String get checkoutProfileRequired =>
      'Please complete your profile information';

  @override
  String checkoutProductNotFound(String productId) {
    return 'Product not found: $productId';
  }

  @override
  String get shopTitle => 'Shop';

  @override
  String get shopSearchHint => 'Search products, styles, colors...';

  @override
  String get shopAll => 'All';

  @override
  String get shopTops => 'Tops';

  @override
  String get shopBottoms => 'Bottoms';

  @override
  String get shopOuterwear => 'Outerwear';

  @override
  String get shopAccessories => 'Accessories';

  @override
  String shopPieces(num count) {
    return '$count pieces';
  }

  @override
  String shopPiece(num count) {
    return '$count piece';
  }

  @override
  String get shopFilter => 'Filter';

  @override
  String get shopSort => 'Sort';

  @override
  String get shopClear => 'Clear';

  @override
  String get shopApply => 'Apply';

  @override
  String get shopPrice => 'Price';

  @override
  String get shopSize => 'Size';

  @override
  String get shopAvailableOnly => 'Available only';

  @override
  String get shopSortNewest => 'Newest';

  @override
  String get shopSortPriceLowToHigh => 'Price: Low to High';

  @override
  String get shopSortPriceHighToLow => 'Price: High to Low';

  @override
  String get shopSortName => 'Name';

  @override
  String get shopNoProducts => 'No products found';

  @override
  String get shopTryAdjustingFilters => 'Try changing your filters or search.';

  @override
  String get shopNoResults => 'No results found';

  @override
  String get shopAddToCart => 'Add to Cart';

  @override
  String get shopOutOfStock => 'Out of Stock';

  @override
  String get shopFilterProducts => 'Filter Products';

  @override
  String get shopSortProducts => 'Sort Products';

  @override
  String get shopSortRecommended => 'Recommended';

  @override
  String get shopSortNameAToZ => 'Name: A to Z';

  @override
  String get productNotFound => 'Product not found';

  @override
  String get productReviews => 'reviews';

  @override
  String get productColor => 'Color';

  @override
  String get productSize => 'Size';

  @override
  String get productSizeGuide => 'Size Guide';

  @override
  String get productFit => 'Fit';

  @override
  String get productAvailable => 'available';

  @override
  String get productOutOfStock => 'Out of stock';

  @override
  String get productOutOfStockButton => 'Out of Stock';

  @override
  String get productAddedToCart => 'Added to cart.';

  @override
  String get productAddedToCartButton => 'Added to Cart';

  @override
  String get productAddToCart => 'Add to Cart';

  @override
  String get productQuickAdd => 'Quick Add';

  @override
  String get productSelectSize => 'Select Size';

  @override
  String get productMaterialComposition => 'Material & Composition';

  @override
  String get productFitSilhouette => 'Fit & Silhouette';

  @override
  String get productStyleAesthetics => 'Style & Aesthetics';

  @override
  String get productCareInstructions => 'Care Instructions';

  @override
  String get productDeliveryReturns => 'Delivery & Returns';

  @override
  String get productMaterialFallback =>
      'Premium fabric composition designed for everyday wear.';

  @override
  String get productFitFallback =>
      'Relaxed silhouette designed for comfortable everyday styling.';

  @override
  String get productStyleFallback => 'Minimal, modern and easy to style.';

  @override
  String get productCareFallback =>
      'Follow the garment care label for best results.';

  @override
  String get productDeliveryFallback =>
      'Delivery and return information will be available at checkout.';

  @override
  String get productCompleteTheLook => 'Complete the Look';

  @override
  String get productCompleteTheLookSubtitle =>
      'Pieces that pair well with this item.';

  @override
  String get productYouMayAlsoLike => 'You May Also Like';

  @override
  String get productCustomerReviews => 'Customer Reviews';

  @override
  String get productWhatCustomersAreSaying => 'What customers are saying';

  @override
  String get productCommunityRatings => 'community ratings';

  @override
  String get productVerifiedCustomer => 'Verified customer';

  @override
  String get productReviewTwoWeeksAgo => '2 weeks ago';

  @override
  String get productReviewOneMonthAgo => '1 month ago';

  @override
  String get productReviewGreatFit =>
      'Great fit and easy to style. The fabric feels premium.';

  @override
  String get productReviewCleanSilhouette =>
      'Clean silhouette and exactly what I expected.';

  @override
  String productViewAllReviews(num count) {
    return 'View All $count Reviews';
  }

  @override
  String get productSizeGuideDescription =>
      'Choose your usual size for the intended fit. Measurements will be connected to the product data later.';

  @override
  String get favoritesEyebrow => 'FAVORITES';

  @override
  String get favoritesTitle => 'Saved for later.';

  @override
  String get favoritesSubtitle => 'Keep the pieces you love close.';

  @override
  String favoritesItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ITEMS',
      one: '1 ITEM',
      zero: '0 ITEMS',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'Nothing saved yet.';

  @override
  String get favoritesEmptyDescription =>
      'Save the pieces that feel like you and come back to them anytime.';

  @override
  String get favoritesExploreShop => 'Explore Shop';

  @override
  String get recentlyViewedTitle => 'RECENTLY VIEWED';

  @override
  String recentlyViewedItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ITEMS',
      one: '1 ITEM',
      zero: '0 ITEMS',
    );
    return '$_temp0';
  }

  @override
  String get recentlyViewedDescription => 'Pieces you\'ve explored recently.';

  @override
  String get recentlyViewedDescriptionSecondary =>
      'Curated from your active browsing footprint.';

  @override
  String get recentlyViewedClearTitle => 'Clear Recently Viewed';

  @override
  String get recentlyViewedClearConfirmation =>
      'Are you sure you want to clear your recently viewed history?';

  @override
  String get recentlyViewedClearHistory => 'Clear Recently Viewed History';

  @override
  String get recentlyViewedLocalStorageNote =>
      'Session items are retained locally across visits.';

  @override
  String get recentlyViewedEmptyTitle => 'Nothing here yet';

  @override
  String get recentlyViewedEmptyDescription =>
      'Products you explore will appear here.';

  @override
  String get recentlyViewedErrorTitle => 'Something went wrong';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get looksEyebrow => 'LOOKS';

  @override
  String get looksTitle => 'Wear it together.';

  @override
  String get looksSubtitle => 'Curated outfits built from ATELIER pieces.';

  @override
  String get lookFilterAll => 'All';

  @override
  String get lookFilterMinimal => 'Minimal';

  @override
  String get lookFilterStreet => 'Street';

  @override
  String get lookFilterCasual => 'Casual';

  @override
  String get lookFilterClassic => 'Classic';

  @override
  String get lookFilterBold => 'Bold';

  @override
  String get lookFilterActive => 'Active';

  @override
  String lookPieces(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'PIECES',
      one: 'PIECE',
    );
    return '$count $_temp0';
  }

  @override
  String get lookLightAfterDarkDescription =>
      'A clean layered uniform built for late city hours and gallery openings.';

  @override
  String get lookCityStaticDescription =>
      'Clean structure with a decisive street tailoring edge and technical outerwear.';

  @override
  String get lookOffDutyDescription =>
      'Relaxed silhouette pieces constructed for everyday unscripted movement.';

  @override
  String get lookAfterHoursDescription =>
      'Sharper tonal silhouettes tailored for dusk onwards and refined nightlife.';

  @override
  String get look01 => 'LOOK 01';

  @override
  String get look02 => 'LOOK 02';

  @override
  String get look03 => 'LOOK 03';

  @override
  String get look04 => 'LOOK 04';

  @override
  String get lookNotFound => 'Look not found';

  @override
  String get lookShopTheLook => 'Shop The Look';

  @override
  String lookAvailableCount(Object count) {
    return '$count available';
  }

  @override
  String get lookShopTheLookDescription =>
      'Complete the outfit with the pieces selected for this look.';

  @override
  String get lookBundleTotal => 'Bundle Total';

  @override
  String lookAddAvailableItems(Object count) {
    return 'Add Available Items ($count)';
  }

  @override
  String lookItemsAddedToBag(Object count) {
    return '$count items added to your bag';
  }

  @override
  String get lookSoldOut => 'SOLD OUT';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileAccountSection => 'ACCOUNT';

  @override
  String get profilePersonalSection => 'PERSONAL';

  @override
  String get profileAppSection => 'APP';

  @override
  String get profileMyOrders => 'My Orders';

  @override
  String get profileMyOrdersSubtitle => 'Track and manage your purchases.';

  @override
  String get profileMyStyle => 'My Style';

  @override
  String get profileStyleBadge => 'SET';

  @override
  String get profileMyStyleSubtitle =>
      'Manage your style, colors, fit, and lifestyle preferences.';

  @override
  String get profileRecentlyViewed => 'Recently Viewed';

  @override
  String get profileRecentlyViewedSubtitle =>
      'Return to pieces you have explored recently.';

  @override
  String get profileAddresses => 'Addresses';

  @override
  String get profileAddressesSubtitle =>
      'Manage your saved delivery addresses.';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileNotificationsSubtitle =>
      'Manage your notifications and preferences.';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileSettingsSubtitle =>
      'Language, appearance, and preferences.';

  @override
  String get profileLogoutTitle => 'Log out of ATELIER?';

  @override
  String get profileLogoutMessage =>
      'You can sign in again anytime to access your account.';

  @override
  String get profileCancel => 'Cancel';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get profileMyAccount => 'MY ACCOUNT';

  @override
  String get profileWelcomeBack => 'Welcome back.';

  @override
  String get profileGuestTitle => 'Welcome to ATELIER.';

  @override
  String get profileGuestDescription =>
      'Sign in to manage your orders, style preferences, and delivery addresses.';

  @override
  String get profileSignIn => 'Sign In';

  @override
  String get profileCreateAccount => 'Create Account';

  @override
  String get ordersEyebrow => 'MY ORDERS';

  @override
  String get ordersTitle => 'Your purchases.';

  @override
  String get ordersSubtitle =>
      'Track your orders and revisit what you’ve bought.';

  @override
  String orderNumber(String number) {
    return 'Order $number';
  }

  @override
  String orderItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ITEMS',
      one: '1 ITEM',
    );
    return '$_temp0';
  }

  @override
  String get orderTotalLabel => 'TOTAL';

  @override
  String get orderTrack => 'TRACK ORDER';

  @override
  String get orderView => 'VIEW ORDER';

  @override
  String get ordersEmptyTitle => 'No orders yet';

  @override
  String get ordersEmptyDescription =>
      'Your purchases will appear here once you place your first order.';

  @override
  String get ordersStartShopping => 'Start Shopping';

  @override
  String get ordersErrorTitle => 'Couldn’t load your orders';

  @override
  String get orderDetailsEyebrow => 'ORDER DETAILS';

  @override
  String orderPlacedOn(String date, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'items',
      one: 'item',
    );
    return 'Placed on $date · $count $_temp0';
  }

  @override
  String get orderItemsTitle => 'ITEMS IN THIS ORDER';

  @override
  String get orderDeliveryAddressTitle => 'DELIVERY & ADDRESS';

  @override
  String get orderPaymentTitle => 'PAYMENT';

  @override
  String get orderSummaryTitle => 'ORDER SUMMARY';

  @override
  String get orderContinueShopping => 'CONTINUE SHOPPING';

  @override
  String get orderShippingMethod => 'SHIPPING METHOD';

  @override
  String get orderDeliveryAddress => 'DELIVERY ADDRESS';

  @override
  String orderQuantity(int count) {
    return 'Qty: $count';
  }

  @override
  String get orderPaymentCompleted => 'COMPLETED';

  @override
  String get orderSubtotal => 'Subtotal';

  @override
  String get orderShipping => 'Shipping';

  @override
  String get orderTotal => 'Total';

  @override
  String orderPaymentMethod(String method) {
    return 'Payment: $method';
  }

  @override
  String get orderNotFound => 'Order not found.';

  @override
  String get orderNotFoundDescription =>
      'This order may no longer be available.';

  @override
  String orderSize(String size) {
    return 'Size $size';
  }

  @override
  String get orderStatusPlaced => 'Placed';

  @override
  String get orderStatusConfirmed => 'Confirmed';

  @override
  String get orderStatusShipped => 'Shipped';

  @override
  String get orderStatusOutForDelivery => 'Out for Delivery';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get orderStatusDescriptionPlaced =>
      'Your order has been placed successfully.';

  @override
  String get orderStatusDescriptionConfirmed =>
      'Your order has been confirmed and is being prepared.';

  @override
  String get orderStatusDescriptionShipped =>
      'Your order has been handed over for delivery.';

  @override
  String get orderStatusDescriptionOutForDelivery =>
      'Your order is on its way to you.';

  @override
  String get orderStatusDescriptionDelivered =>
      'Your order was delivered successfully.';

  @override
  String get orderStatusDescriptionCancelled =>
      'This order has been cancelled.';

  @override
  String get paymentCashOnDelivery => 'Cash on Delivery';

  @override
  String get paymentCard => 'Card Payment';

  @override
  String get paymentCashOnDeliveryDescription => 'Paid upon doorstep delivery';

  @override
  String get paymentMethodDescription => 'Payment method used for this order';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all as read';

  @override
  String get notificationsNow => 'Now';

  @override
  String notificationsMinutesAgo(int count) {
    return '${count}m';
  }

  @override
  String notificationsHoursAgo(int count) {
    return '${count}h';
  }

  @override
  String notificationsDaysAgo(int count) {
    return '${count}d';
  }

  @override
  String get notificationsEmptyTitle => 'No notifications yet';

  @override
  String get notificationsEmptyDescription =>
      'We will let you know when there is something new.';

  @override
  String get notificationsErrorTitle => 'Something went wrong';

  @override
  String get notificationsTryAgain => 'Try again';

  @override
  String get addressEditTitle => 'EDIT ADDRESS';

  @override
  String get addressNewTitle => 'NEW ADDRESS';

  @override
  String get addressUpdateDescription => 'Update your delivery address.';

  @override
  String get addressAddDescription => 'Add a new delivery address.';

  @override
  String get addressSaveDescription =>
      'Save your details for a faster checkout experience.';

  @override
  String get addressFullName => 'FULL NAME';

  @override
  String get addressFullNameHint => 'Youssef Tarek';

  @override
  String get addressPhoneNumber => 'PHONE NUMBER';

  @override
  String get addressPhoneHint => '+20 10 9876 5432';

  @override
  String get addressLabelTitle => 'ADDRESS LABEL';

  @override
  String get addressLabelHome => 'Home';

  @override
  String get addressLabelWork => 'Work';

  @override
  String get addressLabelOther => 'Other';

  @override
  String get addressStreet => 'STREET ADDRESS';

  @override
  String get addressStreetHint => '15 El-Nasr Street, Apt 4B';

  @override
  String get addressCity => 'CITY';

  @override
  String get addressCityHint => 'Beni Suef';

  @override
  String get addressGovernorate => 'GOVERNORATE';

  @override
  String get addressGovernorateHint => 'Beni Suef';

  @override
  String get addressDefaultTitle => 'DEFAULT ADDRESS';

  @override
  String get addressDefaultDescription =>
      'Use this address as your primary delivery address.';

  @override
  String get addressSaveChanges => 'SAVE CHANGES';

  @override
  String get addressSave => 'SAVE ADDRESS';

  @override
  String get addressRequiredField => 'This field is required';

  @override
  String get addressDeliveryTitle => 'Delivery Address';

  @override
  String get addressAddNew => 'Add New Address';

  @override
  String get addressAddNewDescription =>
      'Choose how you want to add your delivery address.';

  @override
  String get addressEnterManually => 'Enter Manually';

  @override
  String get addressEnterManuallyDescription =>
      'Enter your address details yourself.';

  @override
  String get addressChooseOnMap => 'Choose on Map';

  @override
  String get addressChooseOnMapDescription =>
      'Pick a location and complete the address details.';

  @override
  String get locationPickerTitle => 'Select Location';

  @override
  String get locationPickerConfirm => 'Confirm Location';

  @override
  String get checkoutShippingAddressTitle => '02  SHIPPING ADDRESS';

  @override
  String get checkoutNoAddressSelected => 'No delivery address selected.';

  @override
  String get addressChange => 'Change';

  @override
  String get myStyleTitle => 'MY STYLE';

  @override
  String myStyleSelectedCount(int count) {
    return '$count SELECTED';
  }

  @override
  String get myStyleIntroTitle => 'Tell us what feels like you.';

  @override
  String get myStyleIntroDescription =>
      'Your preferences help us personalize what you discover.';

  @override
  String get myStyleSectionStyle => 'STYLE';

  @override
  String get myStyleSectionStyleDescription =>
      'Choose the aesthetics you naturally gravitate toward.';

  @override
  String get myStyleSectionColors => 'COLORS';

  @override
  String get myStyleSectionColorsDescription =>
      'Choose the tones you naturally reach for.';

  @override
  String get myStyleSectionLifestyle => 'LIFESTYLE';

  @override
  String get myStyleSectionLifestyleDescription =>
      'What do you dress for most?';

  @override
  String get myStyleSectionFit => 'FIT';

  @override
  String get myStyleSectionFitDescription =>
      'Choose the silhouettes you prefer.';

  @override
  String get myStyleReset => 'RESET';

  @override
  String get myStyleSaved => 'PREFERENCES SAVED';

  @override
  String get myStyleSaveFailed => 'FAILED TO SAVE PREFERENCES';

  @override
  String get myStyleSave => 'SAVE PREFERENCES';

  @override
  String get styleMinimal => 'Minimal';

  @override
  String get styleStreet => 'Street';

  @override
  String get styleCasual => 'Casual';

  @override
  String get styleClassic => 'Classic';

  @override
  String get styleBold => 'Bold';

  @override
  String get styleActive => 'Active';

  @override
  String get colorNeutral => 'Neutral';

  @override
  String get colorDark => 'Dark';

  @override
  String get colorEarthy => 'Earthy';

  @override
  String get colorLight => 'Light';

  @override
  String get colorBold => 'Bold';

  @override
  String get colorPastel => 'Pastel';

  @override
  String get lifestyleEveryday => 'Everyday';

  @override
  String get lifestyleUniversity => 'University';

  @override
  String get lifestyleWork => 'Work';

  @override
  String get lifestyleGoingOut => 'Going Out';

  @override
  String get lifestyleTravel => 'Travel';

  @override
  String get lifestyleOutdoor => 'Outdoor';

  @override
  String get lifestyleGymActive => 'Gym / Active';

  @override
  String get lifestyleEvents => 'Events';

  @override
  String get fitSlim => 'Slim';

  @override
  String get fitRegular => 'Regular';

  @override
  String get fitRelaxed => 'Relaxed';

  @override
  String get fitOversized => 'Oversized';

  @override
  String get fitWide => 'Wide';

  @override
  String get fitCropped => 'Cropped';

  @override
  String get onboardingDiscoverTitle => 'Discover your style.';

  @override
  String get onboardingDiscoverDescription => 'Find pieces that feel like you.';

  @override
  String get onboardingMoreThanClothesTitle => 'More than clothes.';

  @override
  String get onboardingMoreThanClothesDescription =>
      'Discover looks made to be worn together.';

  @override
  String onboardingLookIndicator(int page, int total) {
    return 'LOOK $page / $total';
  }

  @override
  String get onboardingSkip => 'SKIP';

  @override
  String get onboardingNext => 'NEXT';

  @override
  String get onboardingFinalTitle => 'Made to match you.';

  @override
  String get onboardingFinalDescription =>
      'Get recommendations based on your style, colors, fit, and lifestyle.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingContinueAsGuest => 'Continue as Guest';
}
