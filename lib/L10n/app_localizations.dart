import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'L10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Make ATELIER work your way.'**
  String get settingsSubtitle;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get settingsPreferences;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get settingsAccount;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'PRIVACY'**
  String get settingsPrivacy;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT'**
  String get settingsSupport;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how ATELIER looks.'**
  String get settingsAppearanceSubtitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English or Arabic'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsAccountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get settingsAccountInformation;

  /// No description provided for @settingsAccountInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account details'**
  String get settingsAccountInformationSubtitle;

  /// No description provided for @settingsPasswordSecurity.
  ///
  /// In en, this message translates to:
  /// **'Password & Security'**
  String get settingsPasswordSecurity;

  /// No description provided for @settingsPasswordSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your password and security'**
  String get settingsPasswordSecuritySubtitle;

  /// No description provided for @settingsPrivacyData.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get settingsPrivacyData;

  /// No description provided for @settingsPrivacyDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your privacy preferences'**
  String get settingsPrivacyDataSubtitle;

  /// No description provided for @settingsHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsHelpSupport;

  /// No description provided for @settingsHelpSupportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get help with ATELIER'**
  String get settingsHelpSupportSubtitle;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About ATELIER'**
  String get settingsAbout;

  /// No description provided for @settingsAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App information and version'**
  String get settingsAboutSubtitle;

  /// No description provided for @appearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get appearanceSystem;

  /// No description provided for @appearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceLight;

  /// No description provided for @appearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceDark;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @aboutLegalese.
  ///
  /// In en, this message translates to:
  /// **'© 2026 ATELIER'**
  String get aboutLegalese;

  /// No description provided for @accountInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformationTitle;

  /// No description provided for @accountInformationIntro.
  ///
  /// In en, this message translates to:
  /// **'Manage the personal information associated with your ATELIER account.'**
  String get accountInformationIntro;

  /// No description provided for @accountInformationFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get accountInformationFullName;

  /// No description provided for @accountInformationFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get accountInformationFullNameHint;

  /// No description provided for @accountInformationEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountInformationEmail;

  /// No description provided for @accountInformationSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get accountInformationSave;

  /// No description provided for @accountInformationSaved.
  ///
  /// In en, this message translates to:
  /// **'Your account information has been updated.'**
  String get accountInformationSaved;

  /// No description provided for @accountInformationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Account information is unavailable.'**
  String get accountInformationUnavailable;

  /// No description provided for @passwordSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Password & Security'**
  String get passwordSecurityTitle;

  /// No description provided for @passwordSecurityIntro.
  ///
  /// In en, this message translates to:
  /// **'Keep your ATELIER account secure by updating your password.'**
  String get passwordSecurityIntro;

  /// No description provided for @passwordSecurityNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get passwordSecurityNewPassword;

  /// No description provided for @passwordSecurityNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get passwordSecurityNewPasswordHint;

  /// No description provided for @passwordSecurityConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get passwordSecurityConfirmPassword;

  /// No description provided for @passwordSecurityConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new password'**
  String get passwordSecurityConfirmPasswordHint;

  /// No description provided for @passwordSecurityPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Use a strong password that you do not use elsewhere.'**
  String get passwordSecurityPasswordHint;

  /// No description provided for @passwordSecuritySave.
  ///
  /// In en, this message translates to:
  /// **'SAVE PASSWORD'**
  String get passwordSecuritySave;

  /// No description provided for @passwordSecurityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Your password has been updated.'**
  String get passwordSecurityUpdated;

  /// No description provided for @passwordSecurityFieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both password fields.'**
  String get passwordSecurityFieldsRequired;

  /// No description provided for @passwordSecurityMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordSecurityMismatch;

  /// No description provided for @passwordSecurityMinimumLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordSecurityMinimumLength;

  /// No description provided for @privacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get privacyDataTitle;

  /// No description provided for @privacyDataIntro.
  ///
  /// In en, this message translates to:
  /// **'Manage the data ATELIER stores locally and understand how your account information is used.'**
  String get privacyDataIntro;

  /// No description provided for @privacyLocalDataTitle.
  ///
  /// In en, this message translates to:
  /// **'LOCAL DATA'**
  String get privacyLocalDataTitle;

  /// No description provided for @privacyLocalDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Some app preferences and recently viewed products are stored locally on your device.'**
  String get privacyLocalDataDescription;

  /// No description provided for @privacyRecentlyViewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get privacyRecentlyViewed;

  /// No description provided for @privacyRecentlyViewedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No products saved} =1 {1 product saved} other {{count} products saved}}'**
  String privacyRecentlyViewedCount(num count);

  /// No description provided for @privacyLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get privacyLoading;

  /// No description provided for @privacyClearRecentlyViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Recently Viewed?'**
  String get privacyClearRecentlyViewedTitle;

  /// No description provided for @privacyClearRecentlyViewedMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove all recently viewed products from this device.'**
  String get privacyClearRecentlyViewedMessage;

  /// No description provided for @privacyCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get privacyCancel;

  /// No description provided for @privacyClear.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get privacyClear;

  /// No description provided for @privacyRecentlyViewedCleared.
  ///
  /// In en, this message translates to:
  /// **'Recently viewed products have been cleared.'**
  String get privacyRecentlyViewedCleared;

  /// No description provided for @privacyAccountDataTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT DATA'**
  String get privacyAccountDataTitle;

  /// No description provided for @privacyAccountDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account information is managed securely through your ATELIER account.'**
  String get privacyAccountDataDescription;

  /// No description provided for @privacyAccountData.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get privacyAccountData;

  /// No description provided for @privacyAccountDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your name and email are associated with your account.'**
  String get privacyAccountDataSubtitle;

  /// No description provided for @helpSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportTitle;

  /// No description provided for @helpSupportIntro.
  ///
  /// In en, this message translates to:
  /// **'Find answers or contact the ATELIER support team.'**
  String get helpSupportIntro;

  /// No description provided for @helpSupportContactTitle.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get helpSupportContactTitle;

  /// No description provided for @helpSupportContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpSupportContact;

  /// No description provided for @helpSupportContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send us an email and we\'ll get back to you.'**
  String get helpSupportContactSubtitle;

  /// No description provided for @helpSupportFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get helpSupportFaqTitle;

  /// No description provided for @helpSupportFaq1Question.
  ///
  /// In en, this message translates to:
  /// **'How can I change my password?'**
  String get helpSupportFaq1Question;

  /// No description provided for @helpSupportFaq1Answer.
  ///
  /// In en, this message translates to:
  /// **'Open Settings, choose Password & Security, then enter and confirm your new password.'**
  String get helpSupportFaq1Answer;

  /// No description provided for @helpSupportFaq2Question.
  ///
  /// In en, this message translates to:
  /// **'How can I change my language?'**
  String get helpSupportFaq2Question;

  /// No description provided for @helpSupportFaq2Answer.
  ///
  /// In en, this message translates to:
  /// **'Open Settings, choose Language, then select English or Arabic.'**
  String get helpSupportFaq2Answer;

  /// No description provided for @helpSupportFaq3Question.
  ///
  /// In en, this message translates to:
  /// **'How can I clear recently viewed products?'**
  String get helpSupportFaq3Question;

  /// No description provided for @helpSupportFaq3Answer.
  ///
  /// In en, this message translates to:
  /// **'Open Settings, choose Privacy & Data, then select Recently Viewed and clear the saved products.'**
  String get helpSupportFaq3Answer;

  /// No description provided for @helpSupportProblemTitle.
  ///
  /// In en, this message translates to:
  /// **'PROBLEM'**
  String get helpSupportProblemTitle;

  /// No description provided for @helpSupportReportProblem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get helpSupportReportProblem;

  /// No description provided for @helpSupportReportProblemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us if something isn\'t working as expected.'**
  String get helpSupportReportProblemSubtitle;

  /// No description provided for @helpSupportEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'ATELIER Support Request'**
  String get helpSupportEmailSubject;

  /// No description provided for @helpSupportEmailBody.
  ///
  /// In en, this message translates to:
  /// **'Hi ATELIER Support,\n\nI need help with:\n\n'**
  String get helpSupportEmailBody;

  /// No description provided for @helpSupportProblemSubject.
  ///
  /// In en, this message translates to:
  /// **'ATELIER Problem Report'**
  String get helpSupportProblemSubject;

  /// No description provided for @helpSupportProblemBody.
  ///
  /// In en, this message translates to:
  /// **'Hi ATELIER Support,\n\nI found a problem in the ATELIER app:\n\n'**
  String get helpSupportProblemBody;

  /// No description provided for @helpSupportEmailUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the email app.'**
  String get helpSupportEmailUnavailable;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About ATELIER'**
  String get aboutTitle;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'A modern fashion experience built around discovery, style, and simplicity.'**
  String get aboutDescription;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get aboutCopyright;

  /// No description provided for @aboutPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get aboutPrivacy;

  /// No description provided for @aboutSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get aboutSupport;

  /// No description provided for @aboutMadeFor.
  ///
  /// In en, this message translates to:
  /// **'Designed and built with care for the ATELIER experience.'**
  String get aboutMadeFor;

  /// No description provided for @homeFeatured.
  ///
  /// In en, this message translates to:
  /// **'FEATURED'**
  String get homeFeatured;

  /// No description provided for @homePickedForYou.
  ///
  /// In en, this message translates to:
  /// **'Picked for you'**
  String get homePickedForYou;

  /// No description provided for @homePickedForYouDescription.
  ///
  /// In en, this message translates to:
  /// **'Pieces that match your style.'**
  String get homePickedForYouDescription;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeTrendingNow.
  ///
  /// In en, this message translates to:
  /// **'Trending now'**
  String get homeTrendingNow;

  /// No description provided for @homeNewArrivals.
  ///
  /// In en, this message translates to:
  /// **'New arrivals'**
  String get homeNewArrivals;

  /// No description provided for @homeNewArrivalsDescription.
  ///
  /// In en, this message translates to:
  /// **'Fresh pieces, just in.'**
  String get homeNewArrivalsDescription;

  /// No description provided for @homeExploreCollections.
  ///
  /// In en, this message translates to:
  /// **'Explore collections'**
  String get homeExploreCollections;

  /// No description provided for @homeNoPiecesFound.
  ///
  /// In en, this message translates to:
  /// **'No pieces found'**
  String get homeNoPiecesFound;

  /// No description provided for @homeTryAnotherSearch.
  ///
  /// In en, this message translates to:
  /// **'Try another search.'**
  String get homeTryAnotherSearch;

  /// No description provided for @homeSearchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get homeSearchResults;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search pieces, styles, colors...'**
  String get homeSearchHint;

  /// No description provided for @homeHeroEyebrow.
  ///
  /// In en, this message translates to:
  /// **'DROP 01 — AFTER DARK'**
  String get homeHeroEyebrow;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'New pieces for\nafter-hours.'**
  String get homeHeroTitle;

  /// No description provided for @homeExploreDrop.
  ///
  /// In en, this message translates to:
  /// **'Explore Drop'**
  String get homeExploreDrop;

  /// No description provided for @homeShopTheLookEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LIGHT AFTER DARK'**
  String get homeShopTheLookEyebrow;

  /// No description provided for @homeShopTheLookTitle.
  ///
  /// In en, this message translates to:
  /// **'Oversized Tee +\nBaggy Jeans + Bomber'**
  String get homeShopTheLookTitle;

  /// No description provided for @homeShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get homeShop;

  /// No description provided for @homeArchiveEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ATELIER ARCHIVE'**
  String get homeArchiveEyebrow;

  /// No description provided for @homeArchiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Made to match you.'**
  String get homeArchiveTitle;

  /// No description provided for @homeArchiveDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover pieces, looks, and styles that feel like yours.'**
  String get homeArchiveDescription;

  /// No description provided for @homeExploreAll.
  ///
  /// In en, this message translates to:
  /// **'Explore all'**
  String get homeExploreAll;

  /// Cart title showing the number of items.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {Your Bag (0)} =1 {Your Bag (1 item)} other {Your Bag ({count} items)}}'**
  String cartItemCount(int count);

  /// No description provided for @cartDeliveryUnlockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Complimentary Delivery'**
  String get cartDeliveryUnlockedTitle;

  /// No description provided for @cartDeliveryAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Delivery Available'**
  String get cartDeliveryAvailableTitle;

  /// No description provided for @cartFreeStandardShipping.
  ///
  /// In en, this message translates to:
  /// **'Free standard shipping on your order'**
  String get cartFreeStandardShipping;

  /// Message showing the amount remaining to unlock free delivery.
  ///
  /// In en, this message translates to:
  /// **'Add EGP {amount} to unlock free delivery'**
  String cartAddToFreeDelivery(String amount);

  /// No description provided for @cartUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get cartUnlocked;

  /// No description provided for @cartItems.
  ///
  /// In en, this message translates to:
  /// **'Cart Items'**
  String get cartItems;

  /// No description provided for @cartPricesInclVat.
  ///
  /// In en, this message translates to:
  /// **'Prices incl. VAT'**
  String get cartPricesInclVat;

  /// No description provided for @cartPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get cartPromoCode;

  /// No description provided for @cartApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get cartApply;

  /// No description provided for @cartSummary.
  ///
  /// In en, this message translates to:
  /// **'SUMMARY'**
  String get cartSummary;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartEstimatedShipping.
  ///
  /// In en, this message translates to:
  /// **'Estimated shipping'**
  String get cartEstimatedShipping;

  /// No description provided for @cartFree.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get cartFree;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartTotal;

  /// No description provided for @cartTaxesIncluded.
  ///
  /// In en, this message translates to:
  /// **'Taxes included where applicable.'**
  String get cartTaxesIncluded;

  /// No description provided for @cartSecureCheckout.
  ///
  /// In en, this message translates to:
  /// **'Secure Checkout'**
  String get cartSecureCheckout;

  /// No description provided for @cartFreeReturns.
  ///
  /// In en, this message translates to:
  /// **'14-Day Free Returns'**
  String get cartFreeReturns;

  /// No description provided for @cartEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your bag is empty'**
  String get cartEmptyTitle;

  /// No description provided for @cartEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover pieces made for after-hours.'**
  String get cartEmptyDescription;

  /// No description provided for @cartContinueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get cartContinueShopping;

  /// No description provided for @cartExploreCategories.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE CATEGORIES'**
  String get cartExploreCategories;

  /// No description provided for @cartCategoryOvershirts.
  ///
  /// In en, this message translates to:
  /// **'Overshirts'**
  String get cartCategoryOvershirts;

  /// No description provided for @cartCategoryWidePants.
  ///
  /// In en, this message translates to:
  /// **'Wide Pants'**
  String get cartCategoryWidePants;

  /// No description provided for @cartCategoryBoxyTees.
  ///
  /// In en, this message translates to:
  /// **'Boxy Tees'**
  String get cartCategoryBoxyTees;

  /// No description provided for @cartTotalBag.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BAG'**
  String get cartTotalBag;

  /// No description provided for @cartProceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get cartProceedToCheckout;

  /// No description provided for @cartProductUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This product is no longer available.'**
  String get cartProductUnavailable;

  /// Product size displayed in the cart.
  ///
  /// In en, this message translates to:
  /// **'Size {size}'**
  String cartSize(String size);

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @checkoutEmptyBag.
  ///
  /// In en, this message translates to:
  /// **'Your bag is empty'**
  String get checkoutEmptyBag;

  /// No description provided for @checkoutCompleteOrder.
  ///
  /// In en, this message translates to:
  /// **'Complete your order'**
  String get checkoutCompleteOrder;

  /// Number of items currently in the checkout bag.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No items in your bag} =1 {1 item in your bag} other {{count} items in your bag}}'**
  String checkoutItemCount(num count);

  /// No description provided for @checkoutContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get checkoutContact;

  /// No description provided for @checkoutAccountUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Account information is unavailable.'**
  String get checkoutAccountUnavailable;

  /// No description provided for @checkoutPhoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get checkoutPhoneOptional;

  /// No description provided for @checkoutPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get checkoutPhoneHint;

  /// No description provided for @checkoutShippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get checkoutShippingAddress;

  /// No description provided for @checkoutNoAddress.
  ///
  /// In en, this message translates to:
  /// **'No delivery address selected.'**
  String get checkoutNoAddress;

  /// No description provided for @checkoutChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get checkoutChange;

  /// No description provided for @checkoutShippingMethod.
  ///
  /// In en, this message translates to:
  /// **'Shipping Method'**
  String get checkoutShippingMethod;

  /// No description provided for @shippingStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard Delivery'**
  String get shippingStandard;

  /// No description provided for @shippingStandardDescription.
  ///
  /// In en, this message translates to:
  /// **'3–5 business days'**
  String get shippingStandardDescription;

  /// No description provided for @shippingExpress.
  ///
  /// In en, this message translates to:
  /// **'Express Delivery'**
  String get shippingExpress;

  /// No description provided for @shippingExpressDescription.
  ///
  /// In en, this message translates to:
  /// **'1–2 business days'**
  String get shippingExpressDescription;

  /// No description provided for @checkoutFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get checkoutFree;

  /// No description provided for @checkoutPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get checkoutPayment;

  /// No description provided for @checkoutCod.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get checkoutCod;

  /// No description provided for @checkoutCodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay when your order arrives'**
  String get checkoutCodSubtitle;

  /// No description provided for @checkoutCard.
  ///
  /// In en, this message translates to:
  /// **'Card Payment'**
  String get checkoutCard;

  /// No description provided for @checkoutCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Credit or debit card'**
  String get checkoutCardSubtitle;

  /// No description provided for @checkoutComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get checkoutComingSoon;

  /// No description provided for @checkoutOrderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get checkoutOrderSummary;

  /// No description provided for @checkoutSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get checkoutSubtotal;

  /// No description provided for @checkoutTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get checkoutTotal;

  /// No description provided for @checkoutPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get checkoutPlaceOrder;

  /// No description provided for @checkoutSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Please sign in before placing your order'**
  String get checkoutSignInRequired;

  /// No description provided for @checkoutAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a shipping address'**
  String get checkoutAddressRequired;

  /// No description provided for @checkoutBagEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your bag is empty'**
  String get checkoutBagEmpty;

  /// No description provided for @checkoutProfileRequired.
  ///
  /// In en, this message translates to:
  /// **'Please complete your profile information'**
  String get checkoutProfileRequired;

  /// Shown when a product in the cart cannot be found.
  ///
  /// In en, this message translates to:
  /// **'Product not found: {productId}'**
  String checkoutProductNotFound(String productId);

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shopTitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products, styles, colors...'**
  String get shopSearchHint;

  /// No description provided for @shopAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get shopAll;

  /// No description provided for @shopTops.
  ///
  /// In en, this message translates to:
  /// **'Tops'**
  String get shopTops;

  /// No description provided for @shopBottoms.
  ///
  /// In en, this message translates to:
  /// **'Bottoms'**
  String get shopBottoms;

  /// No description provided for @shopOuterwear.
  ///
  /// In en, this message translates to:
  /// **'Outerwear'**
  String get shopOuterwear;

  /// No description provided for @shopAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get shopAccessories;

  /// Plural product count in the shop.
  ///
  /// In en, this message translates to:
  /// **'{count} pieces'**
  String shopPieces(num count);

  /// Singular product count in the shop.
  ///
  /// In en, this message translates to:
  /// **'{count} piece'**
  String shopPiece(num count);

  /// No description provided for @shopFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get shopFilter;

  /// No description provided for @shopSort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get shopSort;

  /// No description provided for @shopClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get shopClear;

  /// No description provided for @shopApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get shopApply;

  /// No description provided for @shopPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get shopPrice;

  /// No description provided for @shopSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get shopSize;

  /// No description provided for @shopAvailableOnly.
  ///
  /// In en, this message translates to:
  /// **'Available only'**
  String get shopAvailableOnly;

  /// No description provided for @shopSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get shopSortNewest;

  /// No description provided for @shopSortPriceLowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get shopSortPriceLowToHigh;

  /// No description provided for @shopSortPriceHighToLow.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get shopSortPriceHighToLow;

  /// No description provided for @shopSortName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get shopSortName;

  /// No description provided for @shopNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get shopNoProducts;

  /// No description provided for @shopTryAdjustingFilters.
  ///
  /// In en, this message translates to:
  /// **'Try changing your filters or search.'**
  String get shopTryAdjustingFilters;

  /// No description provided for @shopNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get shopNoResults;

  /// No description provided for @shopAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get shopAddToCart;

  /// No description provided for @shopOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get shopOutOfStock;

  /// No description provided for @shopFilterProducts.
  ///
  /// In en, this message translates to:
  /// **'Filter Products'**
  String get shopFilterProducts;

  /// No description provided for @shopSortProducts.
  ///
  /// In en, this message translates to:
  /// **'Sort Products'**
  String get shopSortProducts;

  /// No description provided for @shopSortRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get shopSortRecommended;

  /// No description provided for @shopSortNameAToZ.
  ///
  /// In en, this message translates to:
  /// **'Name: A to Z'**
  String get shopSortNameAToZ;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @productReviews.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get productReviews;

  /// No description provided for @productColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get productColor;

  /// No description provided for @productSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get productSize;

  /// No description provided for @productSizeGuide.
  ///
  /// In en, this message translates to:
  /// **'Size Guide'**
  String get productSizeGuide;

  /// No description provided for @productFit.
  ///
  /// In en, this message translates to:
  /// **'Fit'**
  String get productFit;

  /// No description provided for @productAvailable.
  ///
  /// In en, this message translates to:
  /// **'available'**
  String get productAvailable;

  /// No description provided for @productOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get productOutOfStock;

  /// No description provided for @productOutOfStockButton.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get productOutOfStockButton;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart.'**
  String get productAddedToCart;

  /// No description provided for @productAddedToCartButton.
  ///
  /// In en, this message translates to:
  /// **'Added to Cart'**
  String get productAddedToCartButton;

  /// No description provided for @productAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get productAddToCart;

  /// No description provided for @productQuickAdd.
  ///
  /// In en, this message translates to:
  /// **'Quick Add'**
  String get productQuickAdd;

  /// No description provided for @productSelectSize.
  ///
  /// In en, this message translates to:
  /// **'Select Size'**
  String get productSelectSize;

  /// No description provided for @productMaterialComposition.
  ///
  /// In en, this message translates to:
  /// **'Material & Composition'**
  String get productMaterialComposition;

  /// No description provided for @productFitSilhouette.
  ///
  /// In en, this message translates to:
  /// **'Fit & Silhouette'**
  String get productFitSilhouette;

  /// No description provided for @productStyleAesthetics.
  ///
  /// In en, this message translates to:
  /// **'Style & Aesthetics'**
  String get productStyleAesthetics;

  /// No description provided for @productCareInstructions.
  ///
  /// In en, this message translates to:
  /// **'Care Instructions'**
  String get productCareInstructions;

  /// No description provided for @productDeliveryReturns.
  ///
  /// In en, this message translates to:
  /// **'Delivery & Returns'**
  String get productDeliveryReturns;

  /// No description provided for @productMaterialFallback.
  ///
  /// In en, this message translates to:
  /// **'Premium fabric composition designed for everyday wear.'**
  String get productMaterialFallback;

  /// No description provided for @productFitFallback.
  ///
  /// In en, this message translates to:
  /// **'Relaxed silhouette designed for comfortable everyday styling.'**
  String get productFitFallback;

  /// No description provided for @productStyleFallback.
  ///
  /// In en, this message translates to:
  /// **'Minimal, modern and easy to style.'**
  String get productStyleFallback;

  /// No description provided for @productCareFallback.
  ///
  /// In en, this message translates to:
  /// **'Follow the garment care label for best results.'**
  String get productCareFallback;

  /// No description provided for @productDeliveryFallback.
  ///
  /// In en, this message translates to:
  /// **'Delivery and return information will be available at checkout.'**
  String get productDeliveryFallback;

  /// No description provided for @productCompleteTheLook.
  ///
  /// In en, this message translates to:
  /// **'Complete the Look'**
  String get productCompleteTheLook;

  /// No description provided for @productCompleteTheLookSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pieces that pair well with this item.'**
  String get productCompleteTheLookSubtitle;

  /// No description provided for @productYouMayAlsoLike.
  ///
  /// In en, this message translates to:
  /// **'You May Also Like'**
  String get productYouMayAlsoLike;

  /// No description provided for @productCustomerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get productCustomerReviews;

  /// No description provided for @productWhatCustomersAreSaying.
  ///
  /// In en, this message translates to:
  /// **'What customers are saying'**
  String get productWhatCustomersAreSaying;

  /// No description provided for @productCommunityRatings.
  ///
  /// In en, this message translates to:
  /// **'community ratings'**
  String get productCommunityRatings;

  /// No description provided for @productVerifiedCustomer.
  ///
  /// In en, this message translates to:
  /// **'Verified customer'**
  String get productVerifiedCustomer;

  /// No description provided for @productReviewTwoWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'2 weeks ago'**
  String get productReviewTwoWeeksAgo;

  /// No description provided for @productReviewOneMonthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get productReviewOneMonthAgo;

  /// No description provided for @productReviewGreatFit.
  ///
  /// In en, this message translates to:
  /// **'Great fit and easy to style. The fabric feels premium.'**
  String get productReviewGreatFit;

  /// No description provided for @productReviewCleanSilhouette.
  ///
  /// In en, this message translates to:
  /// **'Clean silhouette and exactly what I expected.'**
  String get productReviewCleanSilhouette;

  /// Button showing the number of product reviews.
  ///
  /// In en, this message translates to:
  /// **'View All {count} Reviews'**
  String productViewAllReviews(num count);

  /// No description provided for @productSizeGuideDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your usual size for the intended fit. Measurements will be connected to the product data later.'**
  String get productSizeGuideDescription;

  /// No description provided for @favoritesEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FAVORITES'**
  String get favoritesEyebrow;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved for later.'**
  String get favoritesTitle;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep the pieces you love close.'**
  String get favoritesSubtitle;

  /// Number of favorite products.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {0 ITEMS} =1 {1 ITEM} other {{count} ITEMS}}'**
  String favoritesItemCount(int count);

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet.'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Save the pieces that feel like you and come back to them anytime.'**
  String get favoritesEmptyDescription;

  /// No description provided for @favoritesExploreShop.
  ///
  /// In en, this message translates to:
  /// **'Explore Shop'**
  String get favoritesExploreShop;

  /// No description provided for @recentlyViewedTitle.
  ///
  /// In en, this message translates to:
  /// **'RECENTLY VIEWED'**
  String get recentlyViewedTitle;

  /// Number of recently viewed products.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {0 ITEMS} =1 {1 ITEM} other {{count} ITEMS}}'**
  String recentlyViewedItemCount(int count);

  /// No description provided for @recentlyViewedDescription.
  ///
  /// In en, this message translates to:
  /// **'Pieces you\'ve explored recently.'**
  String get recentlyViewedDescription;

  /// No description provided for @recentlyViewedDescriptionSecondary.
  ///
  /// In en, this message translates to:
  /// **'Curated from your active browsing footprint.'**
  String get recentlyViewedDescriptionSecondary;

  /// No description provided for @recentlyViewedClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Recently Viewed'**
  String get recentlyViewedClearTitle;

  /// No description provided for @recentlyViewedClearConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear your recently viewed history?'**
  String get recentlyViewedClearConfirmation;

  /// No description provided for @recentlyViewedClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Recently Viewed History'**
  String get recentlyViewedClearHistory;

  /// No description provided for @recentlyViewedLocalStorageNote.
  ///
  /// In en, this message translates to:
  /// **'Session items are retained locally across visits.'**
  String get recentlyViewedLocalStorageNote;

  /// No description provided for @recentlyViewedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get recentlyViewedEmptyTitle;

  /// No description provided for @recentlyViewedEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Products you explore will appear here.'**
  String get recentlyViewedEmptyDescription;

  /// No description provided for @recentlyViewedErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get recentlyViewedErrorTitle;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @looksEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LOOKS'**
  String get looksEyebrow;

  /// No description provided for @looksTitle.
  ///
  /// In en, this message translates to:
  /// **'Wear it together.'**
  String get looksTitle;

  /// No description provided for @looksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Curated outfits built from ATELIER pieces.'**
  String get looksSubtitle;

  /// No description provided for @lookFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get lookFilterAll;

  /// No description provided for @lookFilterMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get lookFilterMinimal;

  /// No description provided for @lookFilterStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get lookFilterStreet;

  /// No description provided for @lookFilterCasual.
  ///
  /// In en, this message translates to:
  /// **'Casual'**
  String get lookFilterCasual;

  /// No description provided for @lookFilterClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get lookFilterClassic;

  /// No description provided for @lookFilterBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get lookFilterBold;

  /// No description provided for @lookFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get lookFilterActive;

  /// No description provided for @lookPieces.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1 {PIECE} other {PIECES}}'**
  String lookPieces(num count);

  /// No description provided for @lookLightAfterDarkDescription.
  ///
  /// In en, this message translates to:
  /// **'A clean layered uniform built for late city hours and gallery openings.'**
  String get lookLightAfterDarkDescription;

  /// No description provided for @lookCityStaticDescription.
  ///
  /// In en, this message translates to:
  /// **'Clean structure with a decisive street tailoring edge and technical outerwear.'**
  String get lookCityStaticDescription;

  /// No description provided for @lookOffDutyDescription.
  ///
  /// In en, this message translates to:
  /// **'Relaxed silhouette pieces constructed for everyday unscripted movement.'**
  String get lookOffDutyDescription;

  /// No description provided for @lookAfterHoursDescription.
  ///
  /// In en, this message translates to:
  /// **'Sharper tonal silhouettes tailored for dusk onwards and refined nightlife.'**
  String get lookAfterHoursDescription;

  /// No description provided for @look01.
  ///
  /// In en, this message translates to:
  /// **'LOOK 01'**
  String get look01;

  /// No description provided for @look02.
  ///
  /// In en, this message translates to:
  /// **'LOOK 02'**
  String get look02;

  /// No description provided for @look03.
  ///
  /// In en, this message translates to:
  /// **'LOOK 03'**
  String get look03;

  /// No description provided for @look04.
  ///
  /// In en, this message translates to:
  /// **'LOOK 04'**
  String get look04;

  /// No description provided for @lookNotFound.
  ///
  /// In en, this message translates to:
  /// **'Look not found'**
  String get lookNotFound;

  /// No description provided for @lookShopTheLook.
  ///
  /// In en, this message translates to:
  /// **'Shop The Look'**
  String get lookShopTheLook;

  /// No description provided for @lookAvailableCount.
  ///
  /// In en, this message translates to:
  /// **'{count} available'**
  String lookAvailableCount(Object count);

  /// No description provided for @lookShopTheLookDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete the outfit with the pieces selected for this look.'**
  String get lookShopTheLookDescription;

  /// No description provided for @lookBundleTotal.
  ///
  /// In en, this message translates to:
  /// **'Bundle Total'**
  String get lookBundleTotal;

  /// No description provided for @lookAddAvailableItems.
  ///
  /// In en, this message translates to:
  /// **'Add Available Items ({count})'**
  String lookAddAvailableItems(Object count);

  /// No description provided for @lookItemsAddedToBag.
  ///
  /// In en, this message translates to:
  /// **'{count} items added to your bag'**
  String lookItemsAddedToBag(Object count);

  /// No description provided for @lookSoldOut.
  ///
  /// In en, this message translates to:
  /// **'SOLD OUT'**
  String get lookSoldOut;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileAccountSection.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get profileAccountSection;

  /// No description provided for @profilePersonalSection.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL'**
  String get profilePersonalSection;

  /// No description provided for @profileAppSection.
  ///
  /// In en, this message translates to:
  /// **'APP'**
  String get profileAppSection;

  /// No description provided for @profileMyOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get profileMyOrders;

  /// No description provided for @profileMyOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track and manage your purchases.'**
  String get profileMyOrdersSubtitle;

  /// No description provided for @profileMyStyle.
  ///
  /// In en, this message translates to:
  /// **'My Style'**
  String get profileMyStyle;

  /// No description provided for @profileStyleBadge.
  ///
  /// In en, this message translates to:
  /// **'SET'**
  String get profileStyleBadge;

  /// No description provided for @profileMyStyleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your style, colors, fit, and lifestyle preferences.'**
  String get profileMyStyleSubtitle;

  /// No description provided for @profileRecentlyViewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get profileRecentlyViewed;

  /// No description provided for @profileRecentlyViewedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Return to pieces you have explored recently.'**
  String get profileRecentlyViewedSubtitle;

  /// No description provided for @profileAddresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get profileAddresses;

  /// No description provided for @profileAddressesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your saved delivery addresses.'**
  String get profileAddressesSubtitle;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your notifications and preferences.'**
  String get profileNotificationsSubtitle;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language, appearance, and preferences.'**
  String get profileSettingsSubtitle;

  /// No description provided for @profileLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out of ATELIER?'**
  String get profileLogoutTitle;

  /// No description provided for @profileLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You can sign in again anytime to access your account.'**
  String get profileLogoutMessage;

  /// No description provided for @profileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileCancel;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogout;

  /// No description provided for @profileMyAccount.
  ///
  /// In en, this message translates to:
  /// **'MY ACCOUNT'**
  String get profileMyAccount;

  /// No description provided for @profileWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back.'**
  String get profileWelcomeBack;

  /// No description provided for @profileGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ATELIER.'**
  String get profileGuestTitle;

  /// No description provided for @profileGuestDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your orders, style preferences, and delivery addresses.'**
  String get profileGuestDescription;

  /// No description provided for @profileSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get profileSignIn;

  /// No description provided for @profileCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get profileCreateAccount;

  /// No description provided for @ordersEyebrow.
  ///
  /// In en, this message translates to:
  /// **'MY ORDERS'**
  String get ordersEyebrow;

  /// No description provided for @ordersTitle.
  ///
  /// In en, this message translates to:
  /// **'Your purchases.'**
  String get ordersTitle;

  /// No description provided for @ordersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your orders and revisit what you’ve bought.'**
  String get ordersSubtitle;

  /// Order number label.
  ///
  /// In en, this message translates to:
  /// **'Order {number}'**
  String orderNumber(String number);

  /// Number of items in an order.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1 {1 ITEM} other {{count} ITEMS}}'**
  String orderItemCount(int count);

  /// No description provided for @orderTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get orderTotalLabel;

  /// No description provided for @orderTrack.
  ///
  /// In en, this message translates to:
  /// **'TRACK ORDER'**
  String get orderTrack;

  /// No description provided for @orderView.
  ///
  /// In en, this message translates to:
  /// **'VIEW ORDER'**
  String get orderView;

  /// No description provided for @ordersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get ordersEmptyTitle;

  /// No description provided for @ordersEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Your purchases will appear here once you place your first order.'**
  String get ordersEmptyDescription;

  /// No description provided for @ordersStartShopping.
  ///
  /// In en, this message translates to:
  /// **'Start Shopping'**
  String get ordersStartShopping;

  /// No description provided for @ordersErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load your orders'**
  String get ordersErrorTitle;

  /// No description provided for @orderDetailsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'ORDER DETAILS'**
  String get orderDetailsEyebrow;

  /// Order placement date and item count.
  ///
  /// In en, this message translates to:
  /// **'Placed on {date} · {count} {count, plural, =1 {item} other {items}}'**
  String orderPlacedOn(String date, int count);

  /// No description provided for @orderItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'ITEMS IN THIS ORDER'**
  String get orderItemsTitle;

  /// No description provided for @orderDeliveryAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'DELIVERY & ADDRESS'**
  String get orderDeliveryAddressTitle;

  /// No description provided for @orderPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT'**
  String get orderPaymentTitle;

  /// No description provided for @orderSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'ORDER SUMMARY'**
  String get orderSummaryTitle;

  /// No description provided for @orderContinueShopping.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE SHOPPING'**
  String get orderContinueShopping;

  /// No description provided for @orderShippingMethod.
  ///
  /// In en, this message translates to:
  /// **'SHIPPING METHOD'**
  String get orderShippingMethod;

  /// No description provided for @orderDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'DELIVERY ADDRESS'**
  String get orderDeliveryAddress;

  /// Quantity of an order item.
  ///
  /// In en, this message translates to:
  /// **'Qty: {count}'**
  String orderQuantity(int count);

  /// No description provided for @orderPaymentCompleted.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get orderPaymentCompleted;

  /// No description provided for @orderSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get orderSubtotal;

  /// No description provided for @orderShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get orderShipping;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// Payment method shown in order summary.
  ///
  /// In en, this message translates to:
  /// **'Payment: {method}'**
  String orderPaymentMethod(String method);

  /// No description provided for @orderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Order not found.'**
  String get orderNotFound;

  /// No description provided for @orderNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'This order may no longer be available.'**
  String get orderNotFoundDescription;

  /// Product size in an order.
  ///
  /// In en, this message translates to:
  /// **'Size {size}'**
  String orderSize(String size);

  /// No description provided for @orderStatusPlaced.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get orderStatusPlaced;

  /// No description provided for @orderStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get orderStatusConfirmed;

  /// No description provided for @orderStatusShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get orderStatusShipped;

  /// No description provided for @orderStatusOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for Delivery'**
  String get orderStatusOutForDelivery;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @orderStatusDescriptionPlaced.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully.'**
  String get orderStatusDescriptionPlaced;

  /// No description provided for @orderStatusDescriptionConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Your order has been confirmed and is being prepared.'**
  String get orderStatusDescriptionConfirmed;

  /// No description provided for @orderStatusDescriptionShipped.
  ///
  /// In en, this message translates to:
  /// **'Your order has been handed over for delivery.'**
  String get orderStatusDescriptionShipped;

  /// No description provided for @orderStatusDescriptionOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Your order is on its way to you.'**
  String get orderStatusDescriptionOutForDelivery;

  /// No description provided for @orderStatusDescriptionDelivered.
  ///
  /// In en, this message translates to:
  /// **'Your order was delivered successfully.'**
  String get orderStatusDescriptionDelivered;

  /// No description provided for @orderStatusDescriptionCancelled.
  ///
  /// In en, this message translates to:
  /// **'This order has been cancelled.'**
  String get orderStatusDescriptionCancelled;

  /// No description provided for @paymentCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get paymentCashOnDelivery;

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card Payment'**
  String get paymentCard;

  /// No description provided for @paymentCashOnDeliveryDescription.
  ///
  /// In en, this message translates to:
  /// **'Paid upon doorstep delivery'**
  String get paymentCashOnDeliveryDescription;

  /// No description provided for @paymentMethodDescription.
  ///
  /// In en, this message translates to:
  /// **'Payment method used for this order'**
  String get paymentMethodDescription;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get notificationsNow;

  /// Minutes elapsed since a notification was created.
  ///
  /// In en, this message translates to:
  /// **'{count}m'**
  String notificationsMinutesAgo(int count);

  /// Hours elapsed since a notification was created.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String notificationsHoursAgo(int count);

  /// Days elapsed since a notification was created.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String notificationsDaysAgo(int count);

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'We will let you know when there is something new.'**
  String get notificationsEmptyDescription;

  /// No description provided for @notificationsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get notificationsErrorTitle;

  /// No description provided for @notificationsTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get notificationsTryAgain;

  /// No description provided for @addressEditTitle.
  ///
  /// In en, this message translates to:
  /// **'EDIT ADDRESS'**
  String get addressEditTitle;

  /// No description provided for @addressNewTitle.
  ///
  /// In en, this message translates to:
  /// **'NEW ADDRESS'**
  String get addressNewTitle;

  /// No description provided for @addressUpdateDescription.
  ///
  /// In en, this message translates to:
  /// **'Update your delivery address.'**
  String get addressUpdateDescription;

  /// No description provided for @addressAddDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a new delivery address.'**
  String get addressAddDescription;

  /// No description provided for @addressSaveDescription.
  ///
  /// In en, this message translates to:
  /// **'Save your details for a faster checkout experience.'**
  String get addressSaveDescription;

  /// No description provided for @addressFullName.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get addressFullName;

  /// No description provided for @addressFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Youssef Tarek'**
  String get addressFullNameHint;

  /// No description provided for @addressPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'PHONE NUMBER'**
  String get addressPhoneNumber;

  /// No description provided for @addressPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+20 10 9876 5432'**
  String get addressPhoneHint;

  /// No description provided for @addressLabelTitle.
  ///
  /// In en, this message translates to:
  /// **'ADDRESS LABEL'**
  String get addressLabelTitle;

  /// No description provided for @addressLabelHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get addressLabelHome;

  /// No description provided for @addressLabelWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get addressLabelWork;

  /// No description provided for @addressLabelOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get addressLabelOther;

  /// No description provided for @addressStreet.
  ///
  /// In en, this message translates to:
  /// **'STREET ADDRESS'**
  String get addressStreet;

  /// No description provided for @addressStreetHint.
  ///
  /// In en, this message translates to:
  /// **'15 El-Nasr Street, Apt 4B'**
  String get addressStreetHint;

  /// No description provided for @addressCity.
  ///
  /// In en, this message translates to:
  /// **'CITY'**
  String get addressCity;

  /// No description provided for @addressCityHint.
  ///
  /// In en, this message translates to:
  /// **'Beni Suef'**
  String get addressCityHint;

  /// No description provided for @addressGovernorate.
  ///
  /// In en, this message translates to:
  /// **'GOVERNORATE'**
  String get addressGovernorate;

  /// No description provided for @addressGovernorateHint.
  ///
  /// In en, this message translates to:
  /// **'Beni Suef'**
  String get addressGovernorateHint;

  /// No description provided for @addressDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'DEFAULT ADDRESS'**
  String get addressDefaultTitle;

  /// No description provided for @addressDefaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Use this address as your primary delivery address.'**
  String get addressDefaultDescription;

  /// No description provided for @addressSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get addressSaveChanges;

  /// No description provided for @addressSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE ADDRESS'**
  String get addressSave;

  /// No description provided for @addressRequiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get addressRequiredField;

  /// No description provided for @addressDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get addressDeliveryTitle;

  /// No description provided for @addressAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addressAddNew;

  /// No description provided for @addressAddNewDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to add your delivery address.'**
  String get addressAddNewDescription;

  /// No description provided for @addressEnterManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Manually'**
  String get addressEnterManually;

  /// No description provided for @addressEnterManuallyDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your address details yourself.'**
  String get addressEnterManuallyDescription;

  /// No description provided for @addressChooseOnMap.
  ///
  /// In en, this message translates to:
  /// **'Choose on Map'**
  String get addressChooseOnMap;

  /// No description provided for @addressChooseOnMapDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick a location and complete the address details.'**
  String get addressChooseOnMapDescription;

  /// No description provided for @locationPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get locationPickerTitle;

  /// No description provided for @locationPickerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get locationPickerConfirm;

  /// No description provided for @checkoutShippingAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'02  SHIPPING ADDRESS'**
  String get checkoutShippingAddressTitle;

  /// No description provided for @checkoutNoAddressSelected.
  ///
  /// In en, this message translates to:
  /// **'No delivery address selected.'**
  String get checkoutNoAddressSelected;

  /// No description provided for @addressChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get addressChange;

  /// No description provided for @myStyleTitle.
  ///
  /// In en, this message translates to:
  /// **'MY STYLE'**
  String get myStyleTitle;

  /// Number of selected style preferences.
  ///
  /// In en, this message translates to:
  /// **'{count} SELECTED'**
  String myStyleSelectedCount(int count);

  /// No description provided for @myStyleIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what feels like you.'**
  String get myStyleIntroTitle;

  /// No description provided for @myStyleIntroDescription.
  ///
  /// In en, this message translates to:
  /// **'Your preferences help us personalize what you discover.'**
  String get myStyleIntroDescription;

  /// No description provided for @myStyleSectionStyle.
  ///
  /// In en, this message translates to:
  /// **'STYLE'**
  String get myStyleSectionStyle;

  /// No description provided for @myStyleSectionStyleDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the aesthetics you naturally gravitate toward.'**
  String get myStyleSectionStyleDescription;

  /// No description provided for @myStyleSectionColors.
  ///
  /// In en, this message translates to:
  /// **'COLORS'**
  String get myStyleSectionColors;

  /// No description provided for @myStyleSectionColorsDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the tones you naturally reach for.'**
  String get myStyleSectionColorsDescription;

  /// No description provided for @myStyleSectionLifestyle.
  ///
  /// In en, this message translates to:
  /// **'LIFESTYLE'**
  String get myStyleSectionLifestyle;

  /// No description provided for @myStyleSectionLifestyleDescription.
  ///
  /// In en, this message translates to:
  /// **'What do you dress for most?'**
  String get myStyleSectionLifestyleDescription;

  /// No description provided for @myStyleSectionFit.
  ///
  /// In en, this message translates to:
  /// **'FIT'**
  String get myStyleSectionFit;

  /// No description provided for @myStyleSectionFitDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the silhouettes you prefer.'**
  String get myStyleSectionFitDescription;

  /// No description provided for @myStyleReset.
  ///
  /// In en, this message translates to:
  /// **'RESET'**
  String get myStyleReset;

  /// No description provided for @myStyleSaved.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES SAVED'**
  String get myStyleSaved;

  /// No description provided for @myStyleSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'FAILED TO SAVE PREFERENCES'**
  String get myStyleSaveFailed;

  /// No description provided for @myStyleSave.
  ///
  /// In en, this message translates to:
  /// **'SAVE PREFERENCES'**
  String get myStyleSave;

  /// No description provided for @styleMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get styleMinimal;

  /// No description provided for @styleStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get styleStreet;

  /// No description provided for @styleCasual.
  ///
  /// In en, this message translates to:
  /// **'Casual'**
  String get styleCasual;

  /// No description provided for @styleClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get styleClassic;

  /// No description provided for @styleBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get styleBold;

  /// No description provided for @styleActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get styleActive;

  /// No description provided for @colorNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get colorNeutral;

  /// No description provided for @colorDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get colorDark;

  /// No description provided for @colorEarthy.
  ///
  /// In en, this message translates to:
  /// **'Earthy'**
  String get colorEarthy;

  /// No description provided for @colorLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get colorLight;

  /// No description provided for @colorBold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get colorBold;

  /// No description provided for @colorPastel.
  ///
  /// In en, this message translates to:
  /// **'Pastel'**
  String get colorPastel;

  /// No description provided for @lifestyleEveryday.
  ///
  /// In en, this message translates to:
  /// **'Everyday'**
  String get lifestyleEveryday;

  /// No description provided for @lifestyleUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get lifestyleUniversity;

  /// No description provided for @lifestyleWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get lifestyleWork;

  /// No description provided for @lifestyleGoingOut.
  ///
  /// In en, this message translates to:
  /// **'Going Out'**
  String get lifestyleGoingOut;

  /// No description provided for @lifestyleTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get lifestyleTravel;

  /// No description provided for @lifestyleOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get lifestyleOutdoor;

  /// No description provided for @lifestyleGymActive.
  ///
  /// In en, this message translates to:
  /// **'Gym / Active'**
  String get lifestyleGymActive;

  /// No description provided for @lifestyleEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get lifestyleEvents;

  /// No description provided for @fitSlim.
  ///
  /// In en, this message translates to:
  /// **'Slim'**
  String get fitSlim;

  /// No description provided for @fitRegular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get fitRegular;

  /// No description provided for @fitRelaxed.
  ///
  /// In en, this message translates to:
  /// **'Relaxed'**
  String get fitRelaxed;

  /// No description provided for @fitOversized.
  ///
  /// In en, this message translates to:
  /// **'Oversized'**
  String get fitOversized;

  /// No description provided for @fitWide.
  ///
  /// In en, this message translates to:
  /// **'Wide'**
  String get fitWide;

  /// No description provided for @fitCropped.
  ///
  /// In en, this message translates to:
  /// **'Cropped'**
  String get fitCropped;

  /// No description provided for @onboardingDiscoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover your style.'**
  String get onboardingDiscoverTitle;

  /// No description provided for @onboardingDiscoverDescription.
  ///
  /// In en, this message translates to:
  /// **'Find pieces that feel like you.'**
  String get onboardingDiscoverDescription;

  /// No description provided for @onboardingMoreThanClothesTitle.
  ///
  /// In en, this message translates to:
  /// **'More than clothes.'**
  String get onboardingMoreThanClothesTitle;

  /// No description provided for @onboardingMoreThanClothesDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover looks made to be worn together.'**
  String get onboardingMoreThanClothesDescription;

  /// Current onboarding page indicator.
  ///
  /// In en, this message translates to:
  /// **'LOOK {page} / {total}'**
  String onboardingLookIndicator(int page, int total);

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get onboardingNext;

  /// No description provided for @onboardingFinalTitle.
  ///
  /// In en, this message translates to:
  /// **'Made to match you.'**
  String get onboardingFinalTitle;

  /// No description provided for @onboardingFinalDescription.
  ///
  /// In en, this message translates to:
  /// **'Get recommendations based on your style, colors, fit, and lifestyle.'**
  String get onboardingFinalDescription;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingContinueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get onboardingContinueAsGuest;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
