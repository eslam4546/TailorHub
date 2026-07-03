import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get logOut => 'Log Out';

  @override
  String get vendorDashboard => 'Vendor Dashboard';

  @override
  String get welcomeShopManager => 'Welcome, Shop Manager';

  @override
  String get shopStatus => 'Shop Status';

  @override
  String get statusAvailable => 'Available';

  @override
  String get statusBusy => 'Busy';

  @override
  String get statusPrayer => 'Closed for Prayer';

  @override
  String get statusStop => 'Stop Tailoring';

  @override
  String statusUpdateFeedback(String status) {
    return 'Shop status updated to \"$status\"';
  }

  @override
  String get realTimeOverview => 'Real-Time Overview';

  @override
  String get peopleInQueue => 'People in Queue';

  @override
  String get activeOrders => 'Active Orders';

  @override
  String get shopSettings => 'Shop Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get businessSettings => 'Business Settings';

  @override
  String get manageServicesPricing => 'Manage Services & Pricing';

  @override
  String get shopSpecialization => 'Shop Specialization';

  @override
  String get mensFashion => 'Men\'s Fashion';

  @override
  String get womensFashion => 'Women\'s Fashion';

  @override
  String get bothFashion => 'Both';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get instapayHandle => 'InstaPay Handle';

  @override
  String get ewalletVodafoneCash => 'E-Wallet / Vodafone Cash';

  @override
  String get acceptCashInShop => 'Accept Cash in Shop';

  @override
  String get appSettings => 'App Settings';

  @override
  String get appLanguage => 'App Language';

  @override
  String get english => 'English';

  @override
  String get notifications => 'Notifications';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get logOutConfirmation =>
      'Are you sure you want to log out of your vendor account?';

  @override
  String get queueManagement => 'Queue Management';

  @override
  String get liveQueue => 'Live Queue';

  @override
  String get queueEmpty => 'Queue is completely empty.';

  @override
  String get activeOrdersEmpty => 'Active Orders will appear here.';

  @override
  String ticketDismissed(String name) {
    return 'Ticket for $name dismissed.';
  }

  @override
  String ticketAccepted(String name) {
    return '$name moved to Active Orders!';
  }

  @override
  String get ordersManagement => 'Orders Management';

  @override
  String get noActiveOrders => 'No Active Orders';

  @override
  String get markReadyForPickup => 'Mark Ready for Pickup';

  @override
  String orderReadyFeedback(String id) {
    return '$id marked as Ready for Pickup!';
  }

  @override
  String get inProduction => 'In Production';

  @override
  String get finalFitting => 'Final Fitting';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get acceptOrder => 'Accept Order';

  @override
  String get rejectOrder => 'Reject Order';

  @override
  String get masterPricing => 'Master Pricing';

  @override
  String get masterPricingSubtitle =>
      'Update your service offerings and set base prices.';

  @override
  String editingService(String serviceName) {
    return 'Editing $serviceName...';
  }

  @override
  String serviceDeleted(String name) {
    return '$name deleted.';
  }

  @override
  String get alterations => 'Alterations';

  @override
  String get bespokeCreation => 'Bespoke Creation';

  @override
  String get repairs => 'Repairs';

  @override
  String get earningsRevenue => 'Earnings & Revenue';

  @override
  String get totalEarnings => 'Total Earnings';

  @override
  String get appOrders => 'App Orders';

  @override
  String get manualCash => 'Manual Cash';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get addManualEntry => 'Add Manual Entry';

  @override
  String get serviceType => 'Service Type (e.g. Alteration)';

  @override
  String get amountEgp => 'Amount (EGP)';

  @override
  String get saveEntry => 'Save Entry';

  @override
  String get navHome => 'Home';

  @override
  String get navMyOrders => 'My Orders';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navProfile => 'Profile';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get findYourTailor => 'Find Your Tailor';

  @override
  String get searchHint => 'Search tailors by name or service...';

  @override
  String get filterAll => 'All';

  @override
  String get filterMensWear => 'Men\'s Wear';

  @override
  String get filterWomensWear => 'Women\'s Wear';

  @override
  String get filterVipAccess => 'VIP Access';

  @override
  String get filterRepairsOnly => 'Repairs Only';

  @override
  String get statusClosed => 'Closed';

  @override
  String get about => 'About';

  @override
  String get servicesAndPricing => 'Services & Pricing';

  @override
  String get allPricesInEgp => 'All prices in Egyptian Pounds (EGP)';

  @override
  String get customerReviews => 'Customer Reviews';

  @override
  String get seeAll => 'See all';

  @override
  String get standardBooking => 'Standard Booking';

  @override
  String get vipHomeService => 'VIP Home Service';

  @override
  String get bookingConfirmed => '✅ Booking confirmed successfully!';

  @override
  String get bookingNewService => 'Booking a new service';

  @override
  String get serviceTypeLabel => 'Service Type';

  @override
  String get tailoringLabel => 'Tailoring';

  @override
  String get repairLabel => 'Repair';

  @override
  String get clothingType => 'Clothing Type';

  @override
  String get selectGarmentHint => 'Select garment type...';

  @override
  String get preferredDate => 'Preferred Date';

  @override
  String get tapToSelectDate => 'Tap to select a date...';

  @override
  String get timeSlot => 'Time Slot';

  @override
  String get specialNotes => 'Special Notes';

  @override
  String get specialNotesHint => 'Any special instructions for the tailor...';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get tailor => 'Tailor';

  @override
  String get service => 'Service';

  @override
  String get garment => 'Garment';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get notSelected => 'Not selected';

  @override
  String get estimatedTotal => 'Estimated Total';

  @override
  String get confirmBooking => 'Confirm Booking';

  @override
  String get vipBookingConfirmed =>
      '🌟 VIP Booking confirmed! The tailor will visit you.';

  @override
  String get vipHomeVisitRequest => 'VIP Home Visit Request';

  @override
  String get premiumVipService => 'Premium VIP Service';

  @override
  String get vipSurchargeNotice =>
      'A professional tailor will visit your home. An additional VIP surcharge of 200 EGP applies.';

  @override
  String get visitAddress => 'Visit Address';

  @override
  String get enterAddressHint => 'Enter your full home address...';

  @override
  String get useCurrentLocation => 'Use Current Location';

  @override
  String get enterAddressManually => 'Enter Address Manually';

  @override
  String get appointmentDate => 'Appointment Date';

  @override
  String get tapToSelectAppointmentDate => 'Tap to select appointment date...';

  @override
  String get preferredTime => 'Preferred Time';

  @override
  String get measurementNotes => 'Measurement Notes';

  @override
  String get measurementNotesHint =>
      'Fabric type, body measurements, urgency level...';

  @override
  String get vipOrderSummary => 'VIP Order Summary';

  @override
  String get address => 'Address';

  @override
  String get notProvided => 'Not provided';

  @override
  String get baseServiceFee => 'Base Service Fee';

  @override
  String get vipSurcharge => 'VIP Surcharge ✨';

  @override
  String get total => 'Total';

  @override
  String get confirmVipBooking => 'Confirm VIP Booking';

  @override
  String get createAccount => 'Create your account';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get iAmA => 'I am a:';

  @override
  String get customer => 'Customer';

  @override
  String get tailorRole => 'Tailor';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'you@example.com';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get yourTailorOneTapAway => 'Your Tailor, One Tap Away';

  @override
  String get tailorHub => 'TailorHub';

  @override
  String get myProfile => 'My Profile';

  @override
  String get myAccount => 'My Account';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get logOutConfirmationTitle => 'Log Out';

  @override
  String get logOutConfirmationContent =>
      'Are you sure you want to log out of your account?';

  @override
  String get noNotificationsYet => 'No notifications yet';

  @override
  String get noNotificationsDesc =>
      'You will see order updates and messages here.';

  @override
  String get justNow => 'Just now';

  @override
  String get hoursAgo => '2 hours ago';

  @override
  String get dayAgo => '1 day ago';

  @override
  String get daysAgo => '3 days ago';

  @override
  String get orderReadyTitle => 'Order Ready for Pickup!';

  @override
  String get orderReadyMessage =>
      'Your Formal Suit is ready. Please visit Ahmed El-Fashionista to collect it.';

  @override
  String get newMessageTitle => 'New Message';

  @override
  String get newMessageMessage =>
      'Fatma\'s Couture sent you a message regarding your Shirt Repair.';

  @override
  String get orderInProgressTitle => 'Order In Progress';

  @override
  String get orderInProgressMessage =>
      'Omar The Tailor has started working on your Custom Galabiya.';

  @override
  String get vipBookingConfirmedTitle => 'VIP Booking Confirmed';

  @override
  String get vipBookingConfirmedMessage =>
      'Ahmed El-Fashionista accepted your VIP Home Service request for tomorrow.';

  @override
  String get myOrders => 'My Orders';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusCompleted => 'Completed';
}
