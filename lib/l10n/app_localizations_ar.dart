import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get cancel => 'إلغاء';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get vendorDashboard => 'لوحة تحكم الترزي';

  @override
  String get welcomeShopManager => 'مرحباً يا مدير المحل';

  @override
  String get shopStatus => 'حالة المحل';

  @override
  String get statusAvailable => 'متاح';

  @override
  String get statusBusy => 'مشغول';

  @override
  String get statusPrayer => 'مغلق للصلاة';

  @override
  String get statusStop => 'إيقاف الاستلام';

  @override
  String statusUpdateFeedback(String status) {
    return 'تم تحديث حالة المحل إلى \"$status\"';
  }

  @override
  String get realTimeOverview => 'نظرة عامة (مباشر)';

  @override
  String get peopleInQueue => 'العملاء في الانتظار';

  @override
  String get activeOrders => 'الطلبات الحالية';

  @override
  String get shopSettings => 'إعدادات المحل';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get businessSettings => 'إعدادات الشغل';

  @override
  String get manageServicesPricing => 'إدارة الخدمات والأسعار';

  @override
  String get shopSpecialization => 'تخصص المحل';

  @override
  String get mensFashion => 'أزياء رجالي';

  @override
  String get womensFashion => 'أزياء حريمي';

  @override
  String get bothFashion => 'رجالي وحريمي';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get instapayHandle => 'حساب إنستاباي (InstaPay)';

  @override
  String get ewalletVodafoneCash => 'محفظة إلكترونية / فودافون كاش';

  @override
  String get acceptCashInShop => 'الدفع كاش في المحل';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get english => 'الإنجليزية';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get logOutConfirmation => 'متأكد إنك عايز تسجل خروج من حساب المحل؟';

  @override
  String get queueManagement => 'إدارة الطابور';

  @override
  String get liveQueue => 'الطابور المباشر';

  @override
  String get queueEmpty => 'الطابور فاضي تماماً.';

  @override
  String get activeOrdersEmpty => 'الطلبات الحالية هتظهر هنا.';

  @override
  String ticketDismissed(String name) {
    return 'تم رفض تذكرة $name.';
  }

  @override
  String ticketAccepted(String name) {
    return 'تم نقل $name للطلبات الحالية!';
  }

  @override
  String get ordersManagement => 'إدارة الطلبات';

  @override
  String get noActiveOrders => 'مفيش طلبات حالية';

  @override
  String get markReadyForPickup => 'جاهز للاستلام';

  @override
  String orderReadyFeedback(String id) {
    return 'تم تحديث $id لـ جاهز للاستلام!';
  }

  @override
  String get inProduction => 'جاري التفصيل';

  @override
  String get finalFitting => 'بروفة نهائية';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get acceptOrder => 'قبول الطلب';

  @override
  String get rejectOrder => 'رفض الطلب';

  @override
  String get masterPricing => 'قائمة الأسعار';

  @override
  String get masterPricingSubtitle => 'حدث خدماتك واضبط الأسعار الأساسية.';

  @override
  String editingService(String serviceName) {
    return 'جاري تعديل $serviceName...';
  }

  @override
  String serviceDeleted(String name) {
    return 'تم حذف $name.';
  }

  @override
  String get alterations => 'تصليحات';

  @override
  String get bespokeCreation => 'تفصيل مخصوص';

  @override
  String get repairs => 'ترميمات';

  @override
  String get earningsRevenue => 'الأرباح والإيرادات';

  @override
  String get totalEarnings => 'إجمالي الأرباح';

  @override
  String get appOrders => 'طلبات التطبيق';

  @override
  String get manualCash => 'كاش يدوي';

  @override
  String get recentTransactions => 'آخر المعاملات';

  @override
  String get addManualEntry => 'إضافة معاملة يدوية';

  @override
  String get serviceType => 'نوع الخدمة (مثال: تقصير)';

  @override
  String get amountEgp => 'المبلغ (جنيه)';

  @override
  String get saveEntry => 'حفظ المعاملة';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navMyOrders => 'طلباتي';

  @override
  String get navNotifications => 'الإشعارات';

  @override
  String get navProfile => 'حسابي';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get welcomeBack => 'مرحباً بعودتك!';

  @override
  String get findYourTailor => 'دور على الترزي بتاعك';

  @override
  String get searchHint => 'دور باسم الترزي أو الخدمة...';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterMensWear => 'رجالي';

  @override
  String get filterWomensWear => 'حريمي';

  @override
  String get filterVipAccess => 'VIP';

  @override
  String get filterRepairsOnly => 'تصليحات بس';

  @override
  String get statusClosed => 'مغلق';

  @override
  String get about => 'نبذة';

  @override
  String get servicesAndPricing => 'الخدمات والأسعار';

  @override
  String get allPricesInEgp => 'جميع الأسعار بالجنيه المصري (EGP)';

  @override
  String get customerReviews => 'تقييمات العملاء';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get standardBooking => 'حجز عادي';

  @override
  String get vipHomeService => 'خدمة VIP منزلية';

  @override
  String get bookingConfirmed => '✅ تم تأكيد الحجز بنجاح!';

  @override
  String get bookingNewService => 'حجز خدمة جديدة';

  @override
  String get serviceTypeLabel => 'نوع الخدمة';

  @override
  String get tailoringLabel => 'تفصيل';

  @override
  String get repairLabel => 'تصليح';

  @override
  String get clothingType => 'نوع الملابس';

  @override
  String get selectGarmentHint => 'اختر نوع الملابس...';

  @override
  String get preferredDate => 'التاريخ المفضل';

  @override
  String get tapToSelectDate => 'اضغط لاختيار التاريخ...';

  @override
  String get timeSlot => 'الوقت المفضل';

  @override
  String get specialNotes => 'ملاحظات خاصة';

  @override
  String get specialNotesHint => 'أي تعليمات خاصة للخياط...';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get tailor => 'الخياط';

  @override
  String get service => 'الخدمة';

  @override
  String get garment => 'الملابس';

  @override
  String get date => 'التاريخ';

  @override
  String get time => 'الوقت';

  @override
  String get notSelected => 'غير محدد';

  @override
  String get estimatedTotal => 'الإجمالي التقديري';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get vipBookingConfirmed => '🌟 تم تأكيد حجز VIP! سيزورك الخياط.';

  @override
  String get vipHomeVisitRequest => 'طلب زيارة منزلية VIP';

  @override
  String get premiumVipService => 'خدمة VIP المتميزة';

  @override
  String get vipSurchargeNotice =>
      'سيزورك خياط محترف في منزلك. تطبق رسوم VIP إضافية بقيمة 200 جنيه.';

  @override
  String get visitAddress => 'عنوان الزيارة';

  @override
  String get enterAddressHint => 'أدخل عنوان منزلك بالكامل...';

  @override
  String get useCurrentLocation => 'استخدام الموقع الحالي';

  @override
  String get enterAddressManually => 'إدخال العنوان يدوياً';

  @override
  String get appointmentDate => 'تاريخ الموعد';

  @override
  String get tapToSelectAppointmentDate => 'اضغط لاختيار تاريخ الموعد...';

  @override
  String get preferredTime => 'الوقت المفضل';

  @override
  String get measurementNotes => 'ملاحظات المقاسات';

  @override
  String get measurementNotesHint =>
      'نوع القماش، مقاسات الجسم، درجة الاستعجال...';

  @override
  String get vipOrderSummary => 'ملخص طلب VIP';

  @override
  String get address => 'العنوان';

  @override
  String get notProvided => 'لم يتم التوفير';

  @override
  String get baseServiceFee => 'رسوم الخدمة الأساسية';

  @override
  String get vipSurcharge => 'رسوم VIP الإضافية ✨';

  @override
  String get total => 'الإجمالي';

  @override
  String get confirmVipBooking => 'تأكيد حجز VIP';

  @override
  String get createAccount => 'إنشاء حسابك';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get iAmA => 'أنا:';

  @override
  String get customer => 'عميل';

  @override
  String get tailorRole => 'خياط';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get enterFullName => 'أدخل اسمك الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'you@example.com';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get yourTailorOneTapAway => 'خياطك بلمسة واحدة';

  @override
  String get tailorHub => 'تيلور هاب';

  @override
  String get myProfile => 'حسابي الشخصي';

  @override
  String get myAccount => 'حسابي';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get logOutConfirmationTitle => 'تسجيل الخروج';

  @override
  String get logOutConfirmationContent =>
      'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات بعد';

  @override
  String get noNotificationsDesc => 'سترى تحديثات الطلبات والرسائل هنا.';

  @override
  String get justNow => 'الآن';

  @override
  String get hoursAgo => 'منذ ساعتين';

  @override
  String get dayAgo => 'منذ يوم واحد';

  @override
  String get daysAgo => 'منذ 3 أيام';

  @override
  String get orderReadyTitle => 'الطلب جاهز للاستلام!';

  @override
  String get orderReadyMessage =>
      'البدلة الرسمية الخاصة بك جاهزة. يرجى زيارة أحمد فاشونيستا لاستلامها.';

  @override
  String get newMessageTitle => 'رسالة جديدة';

  @override
  String get newMessageMessage =>
      'أرسلت لك خياطة فاطمة رسالة بخصوص تصليح القميص.';

  @override
  String get orderInProgressTitle => 'الطلب قيد التنفيذ';

  @override
  String get orderInProgressMessage =>
      'بدأ عمر الخياط العمل على جلابيتك المخصصة.';

  @override
  String get vipBookingConfirmedTitle => 'تم تأكيد حجز VIP';

  @override
  String get vipBookingConfirmedMessage =>
      'وافق أحمد فاشونيستا على طلب الزيارة المنزلية VIP غدًا.';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusInProgress => 'قيد التنفيذ';

  @override
  String get statusCompleted => 'مكتمل';
}
