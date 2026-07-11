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
/// import 'l10n/app_localizations.dart';
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

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @vendorDashboard.
  ///
  /// In en, this message translates to:
  /// **'Vendor Dashboard'**
  String get vendorDashboard;

  /// No description provided for @welcomeShopManager.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Shop Manager'**
  String get welcomeShopManager;

  /// No description provided for @shopStatus.
  ///
  /// In en, this message translates to:
  /// **'Shop Status'**
  String get shopStatus;

  /// No description provided for @statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get statusAvailable;

  /// No description provided for @statusBusy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get statusBusy;

  /// No description provided for @statusPrayer.
  ///
  /// In en, this message translates to:
  /// **'Closed for Prayer'**
  String get statusPrayer;

  /// No description provided for @statusStop.
  ///
  /// In en, this message translates to:
  /// **'Stop Tailoring'**
  String get statusStop;

  /// No description provided for @statusUpdateFeedback.
  ///
  /// In en, this message translates to:
  /// **'Shop status updated to \"{status}\"'**
  String statusUpdateFeedback(String status);

  /// No description provided for @realTimeOverview.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Overview'**
  String get realTimeOverview;

  /// No description provided for @peopleInQueue.
  ///
  /// In en, this message translates to:
  /// **'People in Queue'**
  String get peopleInQueue;

  /// No description provided for @activeOrders.
  ///
  /// In en, this message translates to:
  /// **'Active Orders'**
  String get activeOrders;

  /// No description provided for @shopSettings.
  ///
  /// In en, this message translates to:
  /// **'Shop Settings'**
  String get shopSettings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @businessSettings.
  ///
  /// In en, this message translates to:
  /// **'Business Settings'**
  String get businessSettings;

  /// No description provided for @manageServicesPricing.
  ///
  /// In en, this message translates to:
  /// **'Manage Services & Pricing'**
  String get manageServicesPricing;

  /// No description provided for @shopSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Shop Specialization'**
  String get shopSpecialization;

  /// No description provided for @mensFashion.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Fashion'**
  String get mensFashion;

  /// No description provided for @womensFashion.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Fashion'**
  String get womensFashion;

  /// No description provided for @bothFashion.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get bothFashion;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @instapayHandle.
  ///
  /// In en, this message translates to:
  /// **'InstaPay Handle'**
  String get instapayHandle;

  /// No description provided for @ewalletVodafoneCash.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet / Vodafone Cash'**
  String get ewalletVodafoneCash;

  /// No description provided for @acceptCashInShop.
  ///
  /// In en, this message translates to:
  /// **'Accept Cash in Shop'**
  String get acceptCashInShop;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @logOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your vendor account?'**
  String get logOutConfirmation;

  /// No description provided for @queueManagement.
  ///
  /// In en, this message translates to:
  /// **'Queue Management'**
  String get queueManagement;

  /// No description provided for @liveQueue.
  ///
  /// In en, this message translates to:
  /// **'Live Queue'**
  String get liveQueue;

  /// No description provided for @queueEmpty.
  ///
  /// In en, this message translates to:
  /// **'Queue is completely empty.'**
  String get queueEmpty;

  /// No description provided for @activeOrdersEmpty.
  ///
  /// In en, this message translates to:
  /// **'Active Orders will appear here.'**
  String get activeOrdersEmpty;

  /// No description provided for @ticketDismissed.
  ///
  /// In en, this message translates to:
  /// **'Ticket for {name} dismissed.'**
  String ticketDismissed(String name);

  /// No description provided for @ticketAccepted.
  ///
  /// In en, this message translates to:
  /// **'{name} moved to Active Orders!'**
  String ticketAccepted(String name);

  /// No description provided for @ordersManagement.
  ///
  /// In en, this message translates to:
  /// **'Orders Management'**
  String get ordersManagement;

  /// No description provided for @noActiveOrders.
  ///
  /// In en, this message translates to:
  /// **'No Active Orders'**
  String get noActiveOrders;

  /// No description provided for @markReadyForPickup.
  ///
  /// In en, this message translates to:
  /// **'Mark Ready for Pickup'**
  String get markReadyForPickup;

  /// No description provided for @orderReadyFeedback.
  ///
  /// In en, this message translates to:
  /// **'{id} marked as Ready for Pickup!'**
  String orderReadyFeedback(String id);

  /// No description provided for @inProduction.
  ///
  /// In en, this message translates to:
  /// **'In Production'**
  String get inProduction;

  /// No description provided for @finalFitting.
  ///
  /// In en, this message translates to:
  /// **'Final Fitting'**
  String get finalFitting;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @acceptOrder.
  ///
  /// In en, this message translates to:
  /// **'Accept Order'**
  String get acceptOrder;

  /// No description provided for @rejectOrder.
  ///
  /// In en, this message translates to:
  /// **'Reject Order'**
  String get rejectOrder;

  /// No description provided for @masterPricing.
  ///
  /// In en, this message translates to:
  /// **'Master Pricing'**
  String get masterPricing;

  /// No description provided for @masterPricingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your service offerings and set base prices.'**
  String get masterPricingSubtitle;

  /// No description provided for @editingService.
  ///
  /// In en, this message translates to:
  /// **'Editing {serviceName}...'**
  String editingService(String serviceName);

  /// No description provided for @serviceDeleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted.'**
  String serviceDeleted(String name);

  /// No description provided for @alterations.
  ///
  /// In en, this message translates to:
  /// **'Alterations'**
  String get alterations;

  /// No description provided for @bespokeCreation.
  ///
  /// In en, this message translates to:
  /// **'Bespoke Creation'**
  String get bespokeCreation;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @earningsRevenue.
  ///
  /// In en, this message translates to:
  /// **'Earnings & Revenue'**
  String get earningsRevenue;

  /// No description provided for @totalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get totalEarnings;

  /// No description provided for @appOrders.
  ///
  /// In en, this message translates to:
  /// **'App Orders'**
  String get appOrders;

  /// No description provided for @manualCash.
  ///
  /// In en, this message translates to:
  /// **'Manual Cash'**
  String get manualCash;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @addManualEntry.
  ///
  /// In en, this message translates to:
  /// **'Add Manual Entry'**
  String get addManualEntry;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type (e.g. Alteration)'**
  String get serviceType;

  /// No description provided for @amountEgp.
  ///
  /// In en, this message translates to:
  /// **'Amount (EGP)'**
  String get amountEgp;

  /// No description provided for @saveEntry.
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMyOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get navMyOrders;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @findYourTailor.
  ///
  /// In en, this message translates to:
  /// **'Find Your Tailor'**
  String get findYourTailor;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search tailors by name or service...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterMensWear.
  ///
  /// In en, this message translates to:
  /// **'Men\'s Wear'**
  String get filterMensWear;

  /// No description provided for @filterWomensWear.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Wear'**
  String get filterWomensWear;

  /// No description provided for @filterVipAccess.
  ///
  /// In en, this message translates to:
  /// **'VIP Access'**
  String get filterVipAccess;

  /// No description provided for @filterRepairsOnly.
  ///
  /// In en, this message translates to:
  /// **'Repairs Only'**
  String get filterRepairsOnly;

  /// No description provided for @statusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get statusClosed;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @servicesAndPricing.
  ///
  /// In en, this message translates to:
  /// **'Services & Pricing'**
  String get servicesAndPricing;

  /// No description provided for @allPricesInEgp.
  ///
  /// In en, this message translates to:
  /// **'All prices in Egyptian Pounds (EGP)'**
  String get allPricesInEgp;

  /// No description provided for @customerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customerReviews;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @standardBooking.
  ///
  /// In en, this message translates to:
  /// **'Standard Booking'**
  String get standardBooking;

  /// No description provided for @vipHomeService.
  ///
  /// In en, this message translates to:
  /// **'VIP Home Service'**
  String get vipHomeService;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'✅ Booking confirmed successfully!'**
  String get bookingConfirmed;

  /// No description provided for @bookingNewService.
  ///
  /// In en, this message translates to:
  /// **'Booking a new service'**
  String get bookingNewService;

  /// No description provided for @serviceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceTypeLabel;

  /// No description provided for @tailoringLabel.
  ///
  /// In en, this message translates to:
  /// **'Tailoring'**
  String get tailoringLabel;

  /// No description provided for @repairLabel.
  ///
  /// In en, this message translates to:
  /// **'Repair'**
  String get repairLabel;

  /// No description provided for @clothingType.
  ///
  /// In en, this message translates to:
  /// **'Clothing Type'**
  String get clothingType;

  /// No description provided for @selectGarmentHint.
  ///
  /// In en, this message translates to:
  /// **'Select garment type...'**
  String get selectGarmentHint;

  /// No description provided for @preferredDate.
  ///
  /// In en, this message translates to:
  /// **'Preferred Date'**
  String get preferredDate;

  /// No description provided for @tapToSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Tap to select a date...'**
  String get tapToSelectDate;

  /// No description provided for @timeSlot.
  ///
  /// In en, this message translates to:
  /// **'Time Slot'**
  String get timeSlot;

  /// No description provided for @specialNotes.
  ///
  /// In en, this message translates to:
  /// **'Special Notes'**
  String get specialNotes;

  /// No description provided for @specialNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Any special instructions for the tailor...'**
  String get specialNotesHint;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @tailor.
  ///
  /// In en, this message translates to:
  /// **'Tailor'**
  String get tailor;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @garment.
  ///
  /// In en, this message translates to:
  /// **'Garment'**
  String get garment;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @estimatedTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated Total'**
  String get estimatedTotal;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @vipBookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'🌟 VIP Booking confirmed! The tailor will visit you.'**
  String get vipBookingConfirmed;

  /// No description provided for @vipHomeVisitRequest.
  ///
  /// In en, this message translates to:
  /// **'VIP Home Visit Request'**
  String get vipHomeVisitRequest;

  /// No description provided for @premiumVipService.
  ///
  /// In en, this message translates to:
  /// **'Premium VIP Service'**
  String get premiumVipService;

  /// No description provided for @vipSurchargeNotice.
  ///
  /// In en, this message translates to:
  /// **'A professional tailor will visit your home. An additional VIP surcharge of 200 EGP applies.'**
  String get vipSurchargeNotice;

  /// No description provided for @visitAddress.
  ///
  /// In en, this message translates to:
  /// **'Visit Address'**
  String get visitAddress;

  /// No description provided for @enterAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full home address...'**
  String get enterAddressHint;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get useCurrentLocation;

  /// No description provided for @enterAddressManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Address Manually'**
  String get enterAddressManually;

  /// No description provided for @appointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appointmentDate;

  /// No description provided for @tapToSelectAppointmentDate.
  ///
  /// In en, this message translates to:
  /// **'Tap to select appointment date...'**
  String get tapToSelectAppointmentDate;

  /// No description provided for @preferredTime.
  ///
  /// In en, this message translates to:
  /// **'Preferred Time'**
  String get preferredTime;

  /// No description provided for @measurementNotes.
  ///
  /// In en, this message translates to:
  /// **'Measurement Notes'**
  String get measurementNotes;

  /// No description provided for @measurementNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Fabric type, body measurements, urgency level...'**
  String get measurementNotesHint;

  /// No description provided for @vipOrderSummary.
  ///
  /// In en, this message translates to:
  /// **'VIP Order Summary'**
  String get vipOrderSummary;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @notProvided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get notProvided;

  /// No description provided for @baseServiceFee.
  ///
  /// In en, this message translates to:
  /// **'Base Service Fee'**
  String get baseServiceFee;

  /// No description provided for @vipSurcharge.
  ///
  /// In en, this message translates to:
  /// **'VIP Surcharge ✨'**
  String get vipSurcharge;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @confirmVipBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm VIP Booking'**
  String get confirmVipBooking;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @iAmA.
  ///
  /// In en, this message translates to:
  /// **'I am a:'**
  String get iAmA;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @tailorRole.
  ///
  /// In en, this message translates to:
  /// **'Tailor'**
  String get tailorRole;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @yourTailorOneTapAway.
  ///
  /// In en, this message translates to:
  /// **'Your Tailor, One Tap Away'**
  String get yourTailorOneTapAway;

  /// No description provided for @tailorHub.
  ///
  /// In en, this message translates to:
  /// **'TailorHub'**
  String get tailorHub;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @logOutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOutConfirmationTitle;

  /// No description provided for @logOutConfirmationContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get logOutConfirmationContent;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// No description provided for @noNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'You will see order updates and messages here.'**
  String get noNotificationsDesc;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'2 hours ago'**
  String get hoursAgo;

  /// No description provided for @dayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get dayAgo;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get daysAgo;

  /// No description provided for @orderReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Ready for Pickup!'**
  String get orderReadyTitle;

  /// No description provided for @orderReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your Formal Suit is ready. Please visit Ahmed El-Fashionista to collect it.'**
  String get orderReadyMessage;

  /// No description provided for @newMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get newMessageTitle;

  /// No description provided for @newMessageMessage.
  ///
  /// In en, this message translates to:
  /// **'Fatma\'s Couture sent you a message regarding your Shirt Repair.'**
  String get newMessageMessage;

  /// No description provided for @orderInProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Order In Progress'**
  String get orderInProgressTitle;

  /// No description provided for @orderInProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'Omar The Tailor has started working on your Custom Galabiya.'**
  String get orderInProgressMessage;

  /// No description provided for @vipBookingConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP Booking Confirmed'**
  String get vipBookingConfirmedTitle;

  /// No description provided for @vipBookingConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'Ahmed El-Fashionista accepted your VIP Home Service request for tomorrow.'**
  String get vipBookingConfirmedMessage;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
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
