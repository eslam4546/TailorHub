import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  String get cancel;

  String get logOut;

  String get vendorDashboard;

  String get welcomeShopManager;

  String get shopStatus;

  String get statusAvailable;

  String get statusBusy;

  String get statusPrayer;

  String get statusStop;

  String statusUpdateFeedback(String status);

  String get realTimeOverview;

  String get peopleInQueue;

  String get activeOrders;

  String get shopSettings;

  String get editProfile;

  String get businessSettings;

  String get manageServicesPricing;

  String get shopSpecialization;

  String get mensFashion;

  String get womensFashion;

  String get bothFashion;

  String get paymentMethods;

  String get instapayHandle;

  String get ewalletVodafoneCash;

  String get acceptCashInShop;

  String get appSettings;

  String get appLanguage;

  String get english;

  String get notifications;

  String get helpSupport;

  String get logOutConfirmation;

  String get queueManagement;

  String get liveQueue;

  String get queueEmpty;

  String get activeOrdersEmpty;

  String ticketDismissed(String name);

  String ticketAccepted(String name);

  String get ordersManagement;

  String get noActiveOrders;

  String get markReadyForPickup;

  String orderReadyFeedback(String id);

  String get inProduction;

  String get finalFitting;

  String get orderDetails;

  String get acceptOrder;

  String get rejectOrder;

  String get masterPricing;

  String get masterPricingSubtitle;

  String editingService(String serviceName);

  String serviceDeleted(String name);

  String get alterations;

  String get bespokeCreation;

  String get repairs;

  String get earningsRevenue;

  String get totalEarnings;

  String get appOrders;

  String get manualCash;

  String get recentTransactions;

  String get addManualEntry;

  String get serviceType;

  String get amountEgp;

  String get saveEntry;

  String get navHome;

  String get navMyOrders;

  String get navNotifications;

  String get navProfile;

  String get comingSoon;

  String get welcomeBack;

  String get findYourTailor;

  String get searchHint;

  String get filterAll;

  String get filterMensWear;

  String get filterWomensWear;

  String get filterVipAccess;

  String get filterRepairsOnly;

  String get statusClosed;

  String get about;

  String get servicesAndPricing;

  String get allPricesInEgp;

  String get customerReviews;

  String get seeAll;

  String get standardBooking;

  String get vipHomeService;

  String get bookingConfirmed;

  String get bookingNewService;

  String get serviceTypeLabel;

  String get tailoringLabel;

  String get repairLabel;

  String get clothingType;

  String get selectGarmentHint;

  String get preferredDate;

  String get tapToSelectDate;

  String get timeSlot;

  String get specialNotes;

  String get specialNotesHint;

  String get orderSummary;

  String get tailor;

  String get service;

  String get garment;

  String get date;

  String get time;

  String get notSelected;

  String get estimatedTotal;

  String get confirmBooking;

  String get vipBookingConfirmed;

  String get vipHomeVisitRequest;

  String get premiumVipService;

  String get vipSurchargeNotice;

  String get visitAddress;

  String get enterAddressHint;

  String get useCurrentLocation;

  String get enterAddressManually;

  String get appointmentDate;

  String get tapToSelectAppointmentDate;

  String get preferredTime;

  String get measurementNotes;

  String get measurementNotesHint;

  String get vipOrderSummary;

  String get address;

  String get notProvided;

  String get baseServiceFee;

  String get vipSurcharge;

  String get total;

  String get confirmVipBooking;

  String get createAccount;

  String get login;

  String get signUp;

  String get iAmA;

  String get customer;

  String get tailorRole;

  String get fullName;

  String get enterFullName;

  String get email;

  String get enterEmail;

  String get password;

  String get enterPassword;

  String get dontHaveAccount;

  String get alreadyHaveAccount;

  String get yourTailorOneTapAway;

  String get tailorHub;

  String get myProfile;

  String get myAccount;

  String get helpAndSupport;

  String get logOutConfirmationTitle;

  String get logOutConfirmationContent;

  String get noNotificationsYet;

  String get noNotificationsDesc;

  String get justNow;

  String get hoursAgo;

  String get dayAgo;

  String get daysAgo;

  String get orderReadyTitle;

  String get orderReadyMessage;

  String get newMessageTitle;

  String get newMessageMessage;

  String get orderInProgressTitle;

  String get orderInProgressMessage;

  String get vipBookingConfirmedTitle;

  String get vipBookingConfirmedMessage;

  String get myOrders;

  String get statusPending;

  String get statusInProgress;

  String get statusCompleted;
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
