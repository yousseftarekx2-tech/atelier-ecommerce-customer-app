// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSubtitle => 'اجعل ATELIER يعمل بالطريقة التي تناسبك.';

  @override
  String get settingsPreferences => 'التفضيلات';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsSupport => 'الدعم';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsAppearanceSubtitle => 'اختر مظهر ATELIER.';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSubtitle => 'الإنجليزية أو العربية';

  @override
  String get settingsAccountInformation => 'معلومات الحساب';

  @override
  String get settingsAccountInformationSubtitle => 'إدارة بيانات حسابك';

  @override
  String get settingsPasswordSecurity => 'كلمة المرور والأمان';

  @override
  String get settingsPasswordSecuritySubtitle =>
      'إدارة كلمة المرور وإعدادات الأمان';

  @override
  String get settingsPrivacyData => 'الخصوصية والبيانات';

  @override
  String get settingsPrivacyDataSubtitle => 'إدارة تفضيلات الخصوصية';

  @override
  String get settingsHelpSupport => 'المساعدة والدعم';

  @override
  String get settingsHelpSupportSubtitle => 'احصل على المساعدة في ATELIER';

  @override
  String get settingsAbout => 'عن ATELIER';

  @override
  String get settingsAboutSubtitle => 'معلومات التطبيق والإصدار';

  @override
  String get appearanceSystem => 'النظام';

  @override
  String get appearanceLight => 'فاتح';

  @override
  String get appearanceDark => 'داكن';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get aboutLegalese => '© 2026 ATELIER';

  @override
  String get accountInformationTitle => 'معلومات الحساب';

  @override
  String get accountInformationIntro =>
      'إدارة البيانات الشخصية المرتبطة بحسابك على ATELIER.';

  @override
  String get accountInformationFullName => 'الاسم الكامل';

  @override
  String get accountInformationFullNameHint => 'أدخل اسمك الكامل';

  @override
  String get accountInformationEmail => 'البريد الإلكتروني';

  @override
  String get accountInformationSave => 'حفظ التغييرات';

  @override
  String get accountInformationSaved => 'تم تحديث معلومات حسابك.';

  @override
  String get accountInformationUnavailable => 'معلومات الحساب غير متاحة.';

  @override
  String get passwordSecurityTitle => 'كلمة المرور والأمان';

  @override
  String get passwordSecurityIntro =>
      'حافظ على أمان حسابك في ATELIER من خلال تحديث كلمة المرور.';

  @override
  String get passwordSecurityNewPassword => 'كلمة المرور الجديدة';

  @override
  String get passwordSecurityNewPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get passwordSecurityConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordSecurityConfirmPasswordHint =>
      'أعد إدخال كلمة المرور الجديدة';

  @override
  String get passwordSecurityPasswordHint =>
      'استخدم كلمة مرور قوية لا تستخدمها في حسابات أخرى.';

  @override
  String get passwordSecuritySave => 'حفظ كلمة المرور';

  @override
  String get passwordSecurityUpdated => 'تم تحديث كلمة المرور.';

  @override
  String get passwordSecurityFieldsRequired => 'يرجى ملء حقلي كلمة المرور.';

  @override
  String get passwordSecurityMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get passwordSecurityMinimumLength =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.';

  @override
  String get privacyDataTitle => 'الخصوصية والبيانات';

  @override
  String get privacyDataIntro =>
      'إدارة البيانات التي يخزنها ATELIER محليًا ومعرفة كيفية استخدام معلومات حسابك.';

  @override
  String get privacyLocalDataTitle => 'البيانات المحلية';

  @override
  String get privacyLocalDataDescription =>
      'يتم تخزين بعض تفضيلات التطبيق والمنتجات التي شاهدتها مؤخرًا محليًا على جهازك.';

  @override
  String get privacyRecentlyViewed => 'شاهدتها مؤخرًا';

  @override
  String privacyRecentlyViewedCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# منتج محفوظ',
      many: '# منتجًا محفوظًا',
      few: '# منتجات محفوظة',
      two: 'منتجان محفوظان',
      one: 'منتج واحد محفوظ',
      zero: 'لا توجد منتجات محفوظة',
    );
    return '$_temp0';
  }

  @override
  String get privacyLoading => 'جارٍ التحميل...';

  @override
  String get privacyClearRecentlyViewedTitle =>
      'مسح المنتجات التي شاهدتها مؤخرًا؟';

  @override
  String get privacyClearRecentlyViewedMessage =>
      'سيؤدي هذا إلى إزالة جميع المنتجات التي شاهدتها مؤخرًا من هذا الجهاز.';

  @override
  String get privacyCancel => 'إلغاء';

  @override
  String get privacyClear => 'مسح';

  @override
  String get privacyRecentlyViewedCleared =>
      'تم مسح المنتجات التي شاهدتها مؤخرًا.';

  @override
  String get privacyAccountDataTitle => 'بيانات الحساب';

  @override
  String get privacyAccountDataDescription =>
      'تتم إدارة معلومات حسابك بأمان من خلال حسابك في ATELIER.';

  @override
  String get privacyAccountData => 'معلومات الحساب';

  @override
  String get privacyAccountDataSubtitle =>
      'اسمك وبريدك الإلكتروني مرتبطان بحسابك.';

  @override
  String get helpSupportTitle => 'المساعدة والدعم';

  @override
  String get helpSupportIntro =>
      'اعثر على إجابات أو تواصل مع فريق دعم ATELIER.';

  @override
  String get helpSupportContactTitle => 'التواصل';

  @override
  String get helpSupportContact => 'تواصل مع الدعم';

  @override
  String get helpSupportContactSubtitle =>
      'أرسل لنا بريدًا إلكترونيًا وسنرد عليك.';

  @override
  String get helpSupportFaqTitle => 'الأسئلة الشائعة';

  @override
  String get helpSupportFaq1Question => 'كيف يمكنني تغيير كلمة المرور؟';

  @override
  String get helpSupportFaq1Answer =>
      'افتح الإعدادات، ثم اختر كلمة المرور والأمان، وبعدها أدخل كلمة المرور الجديدة وأكدها.';

  @override
  String get helpSupportFaq2Question => 'كيف يمكنني تغيير اللغة؟';

  @override
  String get helpSupportFaq2Answer =>
      'افتح الإعدادات، ثم اختر اللغة، وبعدها اختر الإنجليزية أو العربية.';

  @override
  String get helpSupportFaq3Question =>
      'كيف يمكنني مسح المنتجات التي شاهدتها مؤخرًا؟';

  @override
  String get helpSupportFaq3Answer =>
      'افتح الإعدادات، ثم اختر الخصوصية والبيانات، وبعدها اختر المنتجات التي شاهدتها مؤخرًا وقم بمسحها.';

  @override
  String get helpSupportProblemTitle => 'مشكلة';

  @override
  String get helpSupportReportProblem => 'الإبلاغ عن مشكلة';

  @override
  String get helpSupportReportProblemSubtitle =>
      'أخبرنا إذا كان هناك شيء لا يعمل كما هو متوقع.';

  @override
  String get helpSupportEmailSubject => 'طلب دعم ATELIER';

  @override
  String get helpSupportEmailBody =>
      'مرحبًا فريق دعم ATELIER،\n\nأحتاج إلى المساعدة في:\n\n';

  @override
  String get helpSupportProblemSubject => 'الإبلاغ عن مشكلة في ATELIER';

  @override
  String get helpSupportProblemBody =>
      'مرحبًا فريق دعم ATELIER،\n\nواجهت مشكلة في تطبيق ATELIER:\n\n';

  @override
  String get helpSupportEmailUnavailable => 'تعذر فتح تطبيق البريد الإلكتروني.';

  @override
  String get aboutTitle => 'عن ATELIER';

  @override
  String get aboutDescription =>
      'تجربة أزياء عصرية مبنية حول الاكتشاف والأسلوب والبساطة.';

  @override
  String get aboutVersion => 'الإصدار';

  @override
  String get aboutCopyright => 'حقوق النشر';

  @override
  String get aboutPrivacy => 'الخصوصية والبيانات';

  @override
  String get aboutSupport => 'المساعدة والدعم';

  @override
  String get aboutMadeFor => 'صُمم وطُوّر بعناية لتقديم تجربة ATELIER.';
}
