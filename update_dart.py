import re

replacements = {
    "lib/features/customer/screens/tailor_profile_screen.dart": {
        "'Tailor Profile'": "AppLocalizations.of(context)!.tailor",
        "'About'": "AppLocalizations.of(context)!.about",
        "'Services & Pricing'": "AppLocalizations.of(context)!.servicesAndPricing",
        "'All prices in Egyptian Pounds (EGP)'": "AppLocalizations.of(context)!.allPricesInEgp",
        "'Customer Reviews'": "AppLocalizations.of(context)!.customerReviews",
        "'See all'": "AppLocalizations.of(context)!.seeAll",
        "'Standard Booking'": "AppLocalizations.of(context)!.standardBooking",
        "'VIP Home Service'": "AppLocalizations.of(context)!.vipHomeService",
        "import '../../core/theme/app_colors.dart';": "import '../../core/theme/app_colors.dart';\nimport 'package:flutter_gen/gen_l10n/app_localizations.dart';"
    },
    "lib/features/customer/screens/regular_booking_screen.dart": {
        "'Booking a new service'": "AppLocalizations.of(context)!.bookingNewService",
        "'✅ Booking confirmed successfully!'": "AppLocalizations.of(context)!.bookingConfirmed",
        "'Service Type'": "AppLocalizations.of(context)!.serviceTypeLabel",
        "'تفصيل\\nTailoring'": "AppLocalizations.of(context)!.tailoringLabel",
        "'تصليح\\nRepair'": "AppLocalizations.of(context)!.repairLabel",
        "'Clothing Type'": "AppLocalizations.of(context)!.clothingType",
        "'Select garment type...'": "AppLocalizations.of(context)!.selectGarmentHint",
        "'Preferred Date'": "AppLocalizations.of(context)!.preferredDate",
        "'Tap to select a date...'": "AppLocalizations.of(context)!.tapToSelectDate",
        "'Time Slot'": "AppLocalizations.of(context)!.timeSlot",
        "'Special Notes'": "AppLocalizations.of(context)!.specialNotes",
        "'Any special instructions for the tailor...'": "AppLocalizations.of(context)!.specialNotesHint",
        "'Order Summary'": "AppLocalizations.of(context)!.orderSummary",
        "'Tailor'": "AppLocalizations.of(context)!.tailor",
        "'Service'": "AppLocalizations.of(context)!.service",
        "'Garment'": "AppLocalizations.of(context)!.garment",
        "'Date'": "AppLocalizations.of(context)!.date",
        "'Not selected'": "AppLocalizations.of(context)!.notSelected",
        "'Time'": "AppLocalizations.of(context)!.time",
        "'Estimated Total'": "AppLocalizations.of(context)!.estimatedTotal",
        "'Confirm Booking'": "AppLocalizations.of(context)!.confirmBooking",
        "import '../../core/theme/app_colors.dart';": "import '../../core/theme/app_colors.dart';\nimport 'package:flutter_gen/gen_l10n/app_localizations.dart';"
    },
    "lib/features/customer/screens/vip_booking_screen.dart": {
        "'🌟 VIP Booking confirmed! The tailor will visit you.'": "AppLocalizations.of(context)!.vipBookingConfirmed",
        "'VIP Home Visit Request'": "AppLocalizations.of(context)!.vipHomeVisitRequest",
        "'Premium VIP Service'": "AppLocalizations.of(context)!.premiumVipService",
        "'A professional tailor will visit your home. An additional VIP surcharge of 200 EGP applies.'": "AppLocalizations.of(context)!.vipSurchargeNotice",
        "'Visit Address'": "AppLocalizations.of(context)!.visitAddress",
        "'Enter your full home address...'": "AppLocalizations.of(context)!.enterAddressHint",
        "'Use Current Location'": "AppLocalizations.of(context)!.useCurrentLocation",
        "'Enter Address Manually'": "AppLocalizations.of(context)!.enterAddressManually",
        "'Appointment Date'": "AppLocalizations.of(context)!.appointmentDate",
        "'Tap to select appointment date...'": "AppLocalizations.of(context)!.tapToSelectAppointmentDate",
        "'Preferred Time'": "AppLocalizations.of(context)!.preferredTime",
        "'Measurement Notes'": "AppLocalizations.of(context)!.measurementNotes",
        "'Fabric type, body measurements, urgency level...'": "AppLocalizations.of(context)!.measurementNotesHint",
        "'VIP Order Summary'": "AppLocalizations.of(context)!.vipOrderSummary",
        "'Address'": "AppLocalizations.of(context)!.address",
        "'Not provided'": "AppLocalizations.of(context)!.notProvided",
        "'Date'": "AppLocalizations.of(context)!.date",
        "'Time'": "AppLocalizations.of(context)!.time",
        "'Not selected'": "AppLocalizations.of(context)!.notSelected",
        "'Base Service Fee'": "AppLocalizations.of(context)!.baseServiceFee",
        "'VIP Surcharge ✨'": "AppLocalizations.of(context)!.vipSurcharge",
        "'Total'": "AppLocalizations.of(context)!.total",
        "'Confirm VIP Booking'": "AppLocalizations.of(context)!.confirmVipBooking",
        "import '../../core/theme/app_colors.dart';": "import '../../core/theme/app_colors.dart';\nimport 'package:flutter_gen/gen_l10n/app_localizations.dart';"
    }
}

for file_path, replace_dict in replacements.items():
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    for old, new in replace_dict.items():
        content = content.replace(old, new)
        
    # Remove const before Text(AppLocalizations...)
    content = re.sub(r'const\s+Text\(\s*AppLocalizations', r'Text(AppLocalizations', content)

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)

print("Dart files updated successfully via python regex!")
