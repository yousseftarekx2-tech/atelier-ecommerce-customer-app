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

  @override
  String get homeFeatured => 'مميز';

  @override
  String get homePickedForYou => 'مختارات لك';

  @override
  String get homePickedForYouDescription => 'قطع تناسب أسلوبك.';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeTrendingNow => 'الأكثر رواجًا';

  @override
  String get homeNewArrivals => 'وصل حديثًا';

  @override
  String get homeNewArrivalsDescription => 'قطع جديدة وصلت للتو.';

  @override
  String get homeExploreCollections => 'استكشف المجموعات';

  @override
  String get homeNoPiecesFound => 'لم يتم العثور على قطع';

  @override
  String get homeTryAnotherSearch => 'جرّب بحثًا آخر.';

  @override
  String get homeSearchResults => 'نتائج البحث';

  @override
  String get homeSearchHint => 'ابحث عن قطع، أساليب، ألوان...';

  @override
  String get homeHeroEyebrow => 'الإصدار 01 — AFTER DARK';

  @override
  String get homeHeroTitle => 'قطع جديدة\nلما بعد الساعات.';

  @override
  String get homeExploreDrop => 'استكشف الإصدار';

  @override
  String get homeShopTheLookEyebrow => 'LIGHT AFTER DARK';

  @override
  String get homeShopTheLookTitle => 'تيشيرت واسع +\nجينز Baggy + بومبر';

  @override
  String get homeShop => 'تسوق';

  @override
  String get homeArchiveEyebrow => 'ATELIER ARCHIVE';

  @override
  String get homeArchiveTitle => 'مصمم ليناسبك.';

  @override
  String get homeArchiveDescription => 'اكتشف قطعًا وإطلالات وأساليب تشبهك.';

  @override
  String get homeExploreAll => 'استكشف الكل';

  @override
  String cartItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حقيبتك (# عنصر)',
      many: 'حقيبتك (# عنصرًا)',
      few: 'حقيبتك (# عناصر)',
      two: 'حقيبتك (عنصران)',
      one: 'حقيبتك (عنصر واحد)',
      zero: 'حقيبتك (0)',
    );
    return '$_temp0';
  }

  @override
  String get cartDeliveryUnlockedTitle => 'توصيل مجاني';

  @override
  String get cartDeliveryAvailableTitle => 'التوصيل المجاني متاح';

  @override
  String get cartFreeStandardShipping => 'الشحن العادي مجاني لطلبك';

  @override
  String cartAddToFreeDelivery(String amount) {
    return 'أضف $amount EGP للحصول على التوصيل المجاني';
  }

  @override
  String get cartUnlocked => 'متاح';

  @override
  String get cartItems => 'عناصر الحقيبة';

  @override
  String get cartPricesInclVat => 'الأسعار شاملة الضريبة';

  @override
  String get cartPromoCode => 'كود الخصم';

  @override
  String get cartApply => 'تطبيق';

  @override
  String get cartSummary => 'الملخص';

  @override
  String get cartSubtotal => 'الإجمالي الفرعي';

  @override
  String get cartEstimatedShipping => 'الشحن المتوقع';

  @override
  String get cartFree => 'مجاني';

  @override
  String get cartTotal => 'الإجمالي';

  @override
  String get cartTaxesIncluded => 'الضرائب مشمولة حيثما ينطبق.';

  @override
  String get cartSecureCheckout => 'دفع آمن';

  @override
  String get cartFreeReturns => 'إرجاع مجاني خلال 14 يومًا';

  @override
  String get cartEmptyTitle => 'حقيبتك فارغة';

  @override
  String get cartEmptyDescription => 'اكتشف قطعًا صُممت لساعاتك الخاصة.';

  @override
  String get cartContinueShopping => 'متابعة التسوق';

  @override
  String get cartExploreCategories => 'استكشف الفئات';

  @override
  String get cartCategoryOvershirts => 'قمصان خارجية';

  @override
  String get cartCategoryWidePants => 'بناطيل واسعة';

  @override
  String get cartCategoryBoxyTees => 'تيشيرتات Boxy';

  @override
  String get cartTotalBag => 'إجمالي الحقيبة';

  @override
  String get cartProceedToCheckout => 'المتابعة إلى الدفع';

  @override
  String get cartProductUnavailable => 'هذا المنتج لم يعد متاحًا.';

  @override
  String cartSize(String size) {
    return 'المقاس $size';
  }

  @override
  String get checkoutTitle => 'الدفع';

  @override
  String get checkoutEmptyBag => 'حقيبتك فارغة';

  @override
  String get checkoutCompleteOrder => 'أكمل طلبك';

  @override
  String checkoutItemCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# منتج في حقيبتك',
      many: '# منتجًا في حقيبتك',
      few: '# منتجات في حقيبتك',
      two: 'منتجان في حقيبتك',
      one: 'منتج واحد في حقيبتك',
      zero: 'لا توجد منتجات في حقيبتك',
    );
    return '$_temp0';
  }

  @override
  String get checkoutContact => 'بيانات التواصل';

  @override
  String get checkoutAccountUnavailable => 'معلومات الحساب غير متاحة.';

  @override
  String get checkoutPhoneOptional => 'رقم الهاتف';

  @override
  String get checkoutPhoneHint => 'أدخل رقم هاتفك';

  @override
  String get checkoutShippingAddress => 'عنوان الشحن';

  @override
  String get checkoutNoAddress => 'لم يتم اختيار عنوان للتوصيل.';

  @override
  String get checkoutChange => 'تغيير';

  @override
  String get checkoutShippingMethod => 'طريقة الشحن';

  @override
  String get shippingStandard => 'الشحن العادي';

  @override
  String get shippingStandardDescription => 'من 3 إلى 5 أيام عمل';

  @override
  String get shippingExpress => 'الشحن السريع';

  @override
  String get shippingExpressDescription => 'من يوم إلى يومين عمل';

  @override
  String get checkoutFree => 'مجانًا';

  @override
  String get checkoutPayment => 'الدفع';

  @override
  String get checkoutCod => 'الدفع عند الاستلام';

  @override
  String get checkoutCodSubtitle => 'ادفع عند وصول طلبك';

  @override
  String get checkoutCard => 'الدفع بالبطاقة';

  @override
  String get checkoutCardSubtitle => 'بطاقة ائتمان أو خصم';

  @override
  String get checkoutComingSoon => 'قريبًا';

  @override
  String get checkoutOrderSummary => 'ملخص الطلب';

  @override
  String get checkoutSubtotal => 'الإجمالي الفرعي';

  @override
  String get checkoutTotal => 'الإجمالي';

  @override
  String get checkoutPlaceOrder => 'تأكيد الطلب';

  @override
  String get checkoutSignInRequired => 'يرجى تسجيل الدخول قبل تأكيد الطلب';

  @override
  String get checkoutAddressRequired => 'يرجى اختيار عنوان الشحن';

  @override
  String get checkoutBagEmpty => 'حقيبتك فارغة';

  @override
  String get checkoutProfileRequired => 'يرجى إكمال بيانات ملفك الشخصي';

  @override
  String checkoutProductNotFound(String productId) {
    return 'المنتج غير موجود: $productId';
  }

  @override
  String get shopTitle => 'المتجر';

  @override
  String get shopSearchHint => 'ابحث عن المنتجات والستايلات والألوان...';

  @override
  String get shopAll => 'الكل';

  @override
  String get shopTops => 'القطع العلوية';

  @override
  String get shopBottoms => 'البناطيل';

  @override
  String get shopOuterwear => 'الملابس الخارجية';

  @override
  String get shopAccessories => 'الإكسسوارات';

  @override
  String shopPieces(num count) {
    return '$count قطع';
  }

  @override
  String shopPiece(num count) {
    return 'قطعة واحدة';
  }

  @override
  String get shopFilter => 'تصفية';

  @override
  String get shopSort => 'ترتيب';

  @override
  String get shopClear => 'مسح';

  @override
  String get shopApply => 'تطبيق';

  @override
  String get shopPrice => 'السعر';

  @override
  String get shopSize => 'المقاس';

  @override
  String get shopAvailableOnly => 'المتاح فقط';

  @override
  String get shopSortNewest => 'الأحدث';

  @override
  String get shopSortPriceLowToHigh => 'السعر: من الأقل للأعلى';

  @override
  String get shopSortPriceHighToLow => 'السعر: من الأعلى للأقل';

  @override
  String get shopSortName => 'الاسم';

  @override
  String get shopNoProducts => 'لا توجد منتجات';

  @override
  String get shopTryAdjustingFilters => 'جرّب تغيير البحث أو خيارات التصفية.';

  @override
  String get shopNoResults => 'لا توجد نتائج';

  @override
  String get shopAddToCart => 'أضف إلى الحقيبة';

  @override
  String get shopOutOfStock => 'غير متوفر';

  @override
  String get shopFilterProducts => 'تصفية المنتجات';

  @override
  String get shopSortProducts => 'ترتيب المنتجات';

  @override
  String get shopSortRecommended => 'المقترح';

  @override
  String get shopSortNameAToZ => 'الاسم: من A إلى Z';

  @override
  String get productNotFound => 'المنتج غير موجود';

  @override
  String get productReviews => 'تقييمات';

  @override
  String get productColor => 'اللون';

  @override
  String get productSize => 'المقاس';

  @override
  String get productSizeGuide => 'دليل المقاسات';

  @override
  String get productFit => 'القصة';

  @override
  String get productAvailable => 'متاح';

  @override
  String get productOutOfStock => 'غير متوفر';

  @override
  String get productOutOfStockButton => 'غير متوفر';

  @override
  String get productAddedToCart => 'تمت الإضافة إلى الحقيبة.';

  @override
  String get productAddedToCartButton => 'تمت الإضافة إلى الحقيبة';

  @override
  String get productAddToCart => 'أضف إلى الحقيبة';

  @override
  String get productQuickAdd => 'إضافة سريعة';

  @override
  String get productSelectSize => 'اختر المقاس';

  @override
  String get productMaterialComposition => 'الخامة والتركيب';

  @override
  String get productFitSilhouette => 'القصة والشكل';

  @override
  String get productStyleAesthetics => 'الستايل والمظهر';

  @override
  String get productCareInstructions => 'تعليمات العناية';

  @override
  String get productDeliveryReturns => 'التوصيل والاسترجاع';

  @override
  String get productMaterialFallback =>
      'خامة عالية الجودة مصممة للاستخدام اليومي.';

  @override
  String get productFitFallback => 'قصة مريحة مصممة لتناسب تنسيقاتك اليومية.';

  @override
  String get productStyleFallback => 'تصميم بسيط وعصري وسهل التنسيق.';

  @override
  String get productCareFallback =>
      'اتبع تعليمات العناية الموجودة على بطاقة المنتج للحصول على أفضل نتيجة.';

  @override
  String get productDeliveryFallback =>
      'ستتوفر معلومات التوصيل والاسترجاع عند إتمام الطلب.';

  @override
  String get productCompleteTheLook => 'أكمل الإطلالة';

  @override
  String get productCompleteTheLookSubtitle =>
      'قطع تتناسق بشكل مثالي مع هذا المنتج.';

  @override
  String get productYouMayAlsoLike => 'قد يعجبك أيضًا';

  @override
  String get productCustomerReviews => 'تقييمات العملاء';

  @override
  String get productWhatCustomersAreSaying => 'آراء العملاء';

  @override
  String get productCommunityRatings => 'تقييمات من العملاء';

  @override
  String get productVerifiedCustomer => 'عميل موثّق';

  @override
  String get productReviewTwoWeeksAgo => 'منذ أسبوعين';

  @override
  String get productReviewOneMonthAgo => 'منذ شهر';

  @override
  String get productReviewGreatFit =>
      'القصة ممتازة وسهلة التنسيق. الخامة تبدو عالية الجودة.';

  @override
  String get productReviewCleanSilhouette =>
      'التصميم نظيف والمنتج مطابق تمامًا لما توقعته.';

  @override
  String productViewAllReviews(num count) {
    return 'عرض جميع التقييمات ($count)';
  }

  @override
  String get productSizeGuideDescription =>
      'اختر مقاسك المعتاد للحصول على القصة المطلوبة. سيتم ربط قياسات المنتجات بالبيانات لاحقًا.';

  @override
  String get favoritesEyebrow => 'المفضلة';

  @override
  String get favoritesTitle => 'محفوظة لوقت لاحق.';

  @override
  String get favoritesSubtitle => 'احتفظ بالقطع التي تحبها بالقرب منك.';

  @override
  String favoritesItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# قطعة',
      many: '# قطعة',
      few: '# قطع',
      two: 'قطعتان',
      one: 'قطعة واحدة',
      zero: '0 قطعة',
    );
    return '$_temp0';
  }

  @override
  String get favoritesEmptyTitle => 'لا توجد قطع محفوظة بعد.';

  @override
  String get favoritesEmptyDescription =>
      'احفظ القطع التي تشبه ذوقك وارجع إليها في أي وقت.';

  @override
  String get favoritesExploreShop => 'استكشف المتجر';

  @override
  String get recentlyViewedTitle => 'شوهدت مؤخرًا';

  @override
  String recentlyViewedItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# قطعة',
      many: '# قطعة',
      few: '# قطع',
      two: 'قطعتان',
      one: 'قطعة واحدة',
      zero: '0 قطعة',
    );
    return '$_temp0';
  }

  @override
  String get recentlyViewedDescription => 'القطع التي تصفحتها مؤخرًا.';

  @override
  String get recentlyViewedDescriptionSecondary =>
      'مجموعة مختارة من المنتجات التي استكشفتها أثناء التصفح.';

  @override
  String get recentlyViewedClearTitle => 'مسح المشاهدة الأخيرة';

  @override
  String get recentlyViewedClearConfirmation =>
      'هل أنت متأكد أنك تريد مسح سجل المنتجات التي شاهدتها مؤخرًا؟';

  @override
  String get recentlyViewedClearHistory => 'مسح سجل المشاهدة الأخيرة';

  @override
  String get recentlyViewedLocalStorageNote =>
      'يتم الاحتفاظ بالمنتجات التي شاهدتها محليًا بين زياراتك.';

  @override
  String get recentlyViewedEmptyTitle => 'لا توجد منتجات هنا بعد';

  @override
  String get recentlyViewedEmptyDescription =>
      'المنتجات التي تستكشفها ستظهر هنا.';

  @override
  String get recentlyViewedErrorTitle => 'حدث خطأ ما';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get looksEyebrow => 'الإطلالات';

  @override
  String get looksTitle => 'نسّقها معًا.';

  @override
  String get looksSubtitle => 'إطلالات مختارة من قطع ATELIER.';

  @override
  String get lookFilterAll => 'الكل';

  @override
  String get lookFilterMinimal => 'مينيمال';

  @override
  String get lookFilterStreet => 'ستريت';

  @override
  String get lookFilterCasual => 'كاجوال';

  @override
  String get lookFilterClassic => 'كلاسيك';

  @override
  String get lookFilterBold => 'جريء';

  @override
  String get lookFilterActive => 'أكتيف';

  @override
  String lookPieces(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قطع',
      many: 'قطعة',
      few: 'قطع',
      two: 'قطعتان',
      one: 'قطعة',
    );
    return '$count $_temp0';
  }

  @override
  String get lookLightAfterDarkDescription =>
      'إطلالة بطبقات نظيفة ومتكاملة لساعات المدينة المتأخرة وافتتاحات المعارض.';

  @override
  String get lookCityStaticDescription =>
      'هيكل نظيف بلمسة ستريت واضحة مع قطع خارجية بطابع تقني.';

  @override
  String get lookOffDutyDescription =>
      'قطع بقصّات مريحة مصممة للحركة اليومية بأسلوب عفوي.';

  @override
  String get lookAfterHoursDescription =>
      'قصّات بدرجات لونية أكثر حدة، مصممة من وقت الغروب وحتى السهرات.';

  @override
  String get look01 => 'الإطلالة 01';

  @override
  String get look02 => 'الإطلالة 02';

  @override
  String get look03 => 'الإطلالة 03';

  @override
  String get look04 => 'الإطلالة 04';

  @override
  String get lookNotFound => 'الإطلالة غير موجودة';

  @override
  String get lookShopTheLook => 'تسوّق الإطلالة';

  @override
  String lookAvailableCount(Object count) {
    return '$count متاح';
  }

  @override
  String get lookShopTheLookDescription =>
      'أكمل الإطلالة بالقطع المختارة لهذا اللوك.';

  @override
  String get lookBundleTotal => 'إجمالي الإطلالة';

  @override
  String lookAddAvailableItems(Object count) {
    return 'أضف القطع المتاحة ($count)';
  }

  @override
  String lookItemsAddedToBag(Object count) {
    return 'تمت إضافة $count قطع إلى حقيبتك';
  }

  @override
  String get lookSoldOut => 'نفدت الكمية';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileAccountSection => 'الحساب';

  @override
  String get profilePersonalSection => 'شخصي';

  @override
  String get profileAppSection => 'التطبيق';

  @override
  String get profileMyOrders => 'طلباتي';

  @override
  String get profileMyOrdersSubtitle => 'تابع مشترياتك وأدرها.';

  @override
  String get profileMyStyle => 'أسلوبي';

  @override
  String get profileStyleBadge => 'مكتمل';

  @override
  String get profileMyStyleSubtitle =>
      'إدارة أسلوبك وألوانك والمقاس وتفضيلات نمط حياتك.';

  @override
  String get profileRecentlyViewed => 'شوهدت مؤخرًا';

  @override
  String get profileRecentlyViewedSubtitle =>
      'ارجع إلى القطع التي استكشفتها مؤخرًا.';

  @override
  String get profileAddresses => 'العناوين';

  @override
  String get profileAddressesSubtitle => 'إدارة عناوين التوصيل المحفوظة.';

  @override
  String get profileNotifications => 'الإشعارات';

  @override
  String get profileNotificationsSubtitle => 'إدارة إشعاراتك وتفضيلاتك.';

  @override
  String get profileSettings => 'الإعدادات';

  @override
  String get profileSettingsSubtitle => 'اللغة والمظهر والتفضيلات.';

  @override
  String get profileLogoutTitle => 'تسجيل الخروج من ATELIER؟';

  @override
  String get profileLogoutMessage =>
      'يمكنك تسجيل الدخول مرة أخرى في أي وقت للوصول إلى حسابك.';

  @override
  String get profileCancel => 'إلغاء';

  @override
  String get profileLogout => 'تسجيل الخروج';

  @override
  String get profileMyAccount => 'حسابي';

  @override
  String get profileWelcomeBack => 'مرحبًا بعودتك.';

  @override
  String get profileGuestTitle => 'مرحبًا بك في ATELIER.';

  @override
  String get profileGuestDescription =>
      'سجّل الدخول لإدارة طلباتك وتفضيلات أسلوبك وعناوين التوصيل.';

  @override
  String get profileSignIn => 'تسجيل الدخول';

  @override
  String get profileCreateAccount => 'إنشاء حساب';

  @override
  String get ordersEyebrow => 'طلباتي';

  @override
  String get ordersTitle => 'مشترياتك.';

  @override
  String get ordersSubtitle => 'تابع طلباتك وارجع إلى ما اشتريته.';

  @override
  String orderNumber(String number) {
    return 'الطلب $number';
  }

  @override
  String orderItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# قطعة',
      many: '# قطعة',
      few: '# قطع',
      two: 'قطعتان',
      one: 'قطعة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get orderTotalLabel => 'الإجمالي';

  @override
  String get orderTrack => 'تتبع الطلب';

  @override
  String get orderView => 'عرض الطلب';

  @override
  String get ordersEmptyTitle => 'لا توجد طلبات بعد';

  @override
  String get ordersEmptyDescription => 'ستظهر مشترياتك هنا بعد إتمام أول طلب.';

  @override
  String get ordersStartShopping => 'ابدأ التسوق';

  @override
  String get ordersErrorTitle => 'تعذر تحميل طلباتك';

  @override
  String get orderDetailsEyebrow => 'تفاصيل الطلب';

  @override
  String orderPlacedOn(String date, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'قطعة',
      many: 'قطعة',
      few: 'قطع',
      two: 'قطعتين',
      one: 'قطعة',
    );
    return 'تم الطلب في $date · $count $_temp0';
  }

  @override
  String get orderItemsTitle => 'القطع في هذا الطلب';

  @override
  String get orderDeliveryAddressTitle => 'التوصيل والعنوان';

  @override
  String get orderPaymentTitle => 'الدفع';

  @override
  String get orderSummaryTitle => 'ملخص الطلب';

  @override
  String get orderContinueShopping => 'متابعة التسوق';

  @override
  String get orderShippingMethod => 'طريقة الشحن';

  @override
  String get orderDeliveryAddress => 'عنوان التوصيل';

  @override
  String orderQuantity(int count) {
    return 'الكمية: $count';
  }

  @override
  String get orderPaymentCompleted => 'مكتمل';

  @override
  String get orderSubtotal => 'المجموع الفرعي';

  @override
  String get orderShipping => 'الشحن';

  @override
  String get orderTotal => 'الإجمالي';

  @override
  String orderPaymentMethod(String method) {
    return 'طريقة الدفع: $method';
  }

  @override
  String get orderNotFound => 'الطلب غير موجود.';

  @override
  String get orderNotFoundDescription => 'قد لا يكون هذا الطلب متاحًا anymore.';

  @override
  String orderSize(String size) {
    return 'المقاس $size';
  }

  @override
  String get orderStatusPlaced => 'تم الطلب';

  @override
  String get orderStatusConfirmed => 'تم التأكيد';

  @override
  String get orderStatusShipped => 'تم الشحن';

  @override
  String get orderStatusOutForDelivery => 'خرج للتوصيل';

  @override
  String get orderStatusDelivered => 'تم التوصيل';

  @override
  String get orderStatusCancelled => 'تم الإلغاء';

  @override
  String get orderStatusDescriptionPlaced => 'تم إنشاء طلبك بنجاح.';

  @override
  String get orderStatusDescriptionConfirmed => 'تم تأكيد طلبك ويجري تجهيزه.';

  @override
  String get orderStatusDescriptionShipped => 'تم تسليم طلبك لشركة التوصيل.';

  @override
  String get orderStatusDescriptionOutForDelivery => 'طلبك في طريقه إليك.';

  @override
  String get orderStatusDescriptionDelivered => 'تم توصيل طلبك بنجاح.';

  @override
  String get orderStatusDescriptionCancelled => 'تم إلغاء هذا الطلب.';

  @override
  String get paymentCashOnDelivery => 'الدفع عند الاستلام';

  @override
  String get paymentCard => 'الدفع بالبطاقة';

  @override
  String get paymentCashOnDeliveryDescription => 'الدفع عند وصول الطلب';

  @override
  String get paymentMethodDescription => 'طريقة الدفع المستخدمة لهذا الطلب';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsMarkAllRead => 'تحديد الكل كمقروء';

  @override
  String get notificationsNow => 'الآن';

  @override
  String notificationsMinutesAgo(int count) {
    return 'منذ $count د';
  }

  @override
  String notificationsHoursAgo(int count) {
    return 'منذ $count س';
  }

  @override
  String notificationsDaysAgo(int count) {
    return 'منذ $count يوم';
  }

  @override
  String get notificationsEmptyTitle => 'لا توجد إشعارات بعد';

  @override
  String get notificationsEmptyDescription =>
      'سنخبرك عندما يكون هناك شيء جديد.';

  @override
  String get notificationsErrorTitle => 'حدث خطأ ما';

  @override
  String get notificationsTryAgain => 'حاول مرة أخرى';

  @override
  String get addressEditTitle => 'تعديل العنوان';

  @override
  String get addressNewTitle => 'عنوان جديد';

  @override
  String get addressUpdateDescription => 'حدّث عنوان التوصيل الخاص بك.';

  @override
  String get addressAddDescription => 'أضف عنوان توصيل جديدًا.';

  @override
  String get addressSaveDescription => 'احفظ بياناتك لتجربة دفع أسرع.';

  @override
  String get addressFullName => 'الاسم الكامل';

  @override
  String get addressFullNameHint => 'يوسف طارق';

  @override
  String get addressPhoneNumber => 'رقم الهاتف';

  @override
  String get addressPhoneHint => '+20 10 9876 5432';

  @override
  String get addressLabelTitle => 'نوع العنوان';

  @override
  String get addressLabelHome => 'المنزل';

  @override
  String get addressLabelWork => 'العمل';

  @override
  String get addressLabelOther => 'آخر';

  @override
  String get addressStreet => 'عنوان الشارع';

  @override
  String get addressStreetHint => '15 شارع النصر، شقة 4B';

  @override
  String get addressCity => 'المدينة';

  @override
  String get addressCityHint => 'بني سويف';

  @override
  String get addressGovernorate => 'المحافظة';

  @override
  String get addressGovernorateHint => 'بني سويف';

  @override
  String get addressDefaultTitle => 'العنوان الافتراضي';

  @override
  String get addressDefaultDescription =>
      'استخدم هذا العنوان كعنوان التوصيل الأساسي.';

  @override
  String get addressSaveChanges => 'حفظ التغييرات';

  @override
  String get addressSave => 'حفظ العنوان';

  @override
  String get addressRequiredField => 'هذا الحقل مطلوب';

  @override
  String get addressDeliveryTitle => 'عنوان التوصيل';

  @override
  String get addressAddNew => 'إضافة عنوان جديد';

  @override
  String get addressAddNewDescription =>
      'اختر الطريقة التي تريد بها إضافة عنوان التوصيل.';

  @override
  String get addressEnterManually => 'إدخال يدوي';

  @override
  String get addressEnterManuallyDescription => 'أدخل بيانات عنوانك بنفسك.';

  @override
  String get addressChooseOnMap => 'اختيار من الخريطة';

  @override
  String get addressChooseOnMapDescription =>
      'اختر موقعًا وأكمل بيانات العنوان.';

  @override
  String get locationPickerTitle => 'اختيار الموقع';

  @override
  String get locationPickerConfirm => 'تأكيد الموقع';

  @override
  String get checkoutShippingAddressTitle => '02  عنوان التوصيل';

  @override
  String get checkoutNoAddressSelected => 'لم يتم اختيار عنوان توصيل.';

  @override
  String get addressChange => 'تغيير';

  @override
  String get myStyleTitle => 'أسلوبي';

  @override
  String myStyleSelectedCount(int count) {
    return '$count محدد';
  }

  @override
  String get myStyleIntroTitle => 'اختر ما يشبهك.';

  @override
  String get myStyleIntroDescription => 'تساعدنا تفضيلاتك على تخصيص ما تكتشفه.';

  @override
  String get myStyleSectionStyle => 'الأسلوب';

  @override
  String get myStyleSectionStyleDescription =>
      'اختر الأساليب الجمالية التي تميل إليها بشكل طبيعي.';

  @override
  String get myStyleSectionColors => 'الألوان';

  @override
  String get myStyleSectionColorsDescription =>
      'اختر الدرجات التي تفضل ارتداءها بشكل طبيعي.';

  @override
  String get myStyleSectionLifestyle => 'نمط الحياة';

  @override
  String get myStyleSectionLifestyleDescription =>
      'لأي نوع من المناسبات تختار ملابسك غالبًا؟';

  @override
  String get myStyleSectionFit => 'القَصّة';

  @override
  String get myStyleSectionFitDescription => 'اختر القصّات التي تفضلها.';

  @override
  String get myStyleReset => 'إعادة تعيين';

  @override
  String get myStyleSaved => 'تم حفظ التفضيلات';

  @override
  String get myStyleSaveFailed => 'تعذر حفظ التفضيلات';

  @override
  String get myStyleSave => 'حفظ التفضيلات';

  @override
  String get styleMinimal => 'مينيمال';

  @override
  String get styleStreet => 'ستريت';

  @override
  String get styleCasual => 'كاجوال';

  @override
  String get styleClassic => 'كلاسيك';

  @override
  String get styleBold => 'جريء';

  @override
  String get styleActive => 'أكتيف';

  @override
  String get colorNeutral => 'محايد';

  @override
  String get colorDark => 'داكن';

  @override
  String get colorEarthy => 'ترابي';

  @override
  String get colorLight => 'فاتح';

  @override
  String get colorBold => 'جريء';

  @override
  String get colorPastel => 'باستيل';

  @override
  String get lifestyleEveryday => 'يومي';

  @override
  String get lifestyleUniversity => 'الجامعة';

  @override
  String get lifestyleWork => 'العمل';

  @override
  String get lifestyleGoingOut => 'الخروج';

  @override
  String get lifestyleTravel => 'السفر';

  @override
  String get lifestyleOutdoor => 'أنشطة خارجية';

  @override
  String get lifestyleGymActive => 'الجيم / أكتيف';

  @override
  String get lifestyleEvents => 'المناسبات';

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
  String get onboardingDiscoverTitle => 'اكتشف أسلوبك.';

  @override
  String get onboardingDiscoverDescription => 'اكتشف قطعًا تشبهك.';

  @override
  String get onboardingMoreThanClothesTitle => 'أكثر من مجرد ملابس.';

  @override
  String get onboardingMoreThanClothesDescription =>
      'اكتشف إطلالات صُممت لتُرتدى معًا.';

  @override
  String onboardingLookIndicator(int page, int total) {
    return 'الإطلالة $page / $total';
  }

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingFinalTitle => 'مصممة لتناسبك.';

  @override
  String get onboardingFinalDescription =>
      'احصل على توصيات بناءً على أسلوبك وألوانك وقصّاتك ونمط حياتك.';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingContinueAsGuest => 'المتابعة كزائر';
}
