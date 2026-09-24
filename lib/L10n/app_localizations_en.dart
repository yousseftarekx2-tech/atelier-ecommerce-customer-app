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
}
