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
