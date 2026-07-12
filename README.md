# TailorHub

**TailorHub** is a comprehensive B2B2C community-based platform designed to connect customers with local tailoring services seamlessly. The app provides specialized, distinct flows for two main user personas:
1. **Vendors (Tailors):** Manage shop settings, digital queues, incoming orders, and service pricing.
2. **Customers:** Browse local tailors, book standard or VIP home-visit tailoring services, and track order progress.

## Technology Stack

- **Framework:** Flutter (Dart)
- **UI/UX:** Material 3 Design
- **State Management:** StatefulWidgets (Global `Locale` management via root `TailorHubApp`)
- **Localization:** `flutter_localizations` (Dynamic English & Egyptian Arabic support)
- **Backend (Planned):** Firebase Integration (Authentication, Firestore, Cloud Functions)

## Folder Structure

The project utilizes a **feature-first architecture** to ensure maintainability, clear boundaries, and scalability:

```text
tailor_shop/
├── lib/                                    # Main application code
│   ├── core/                               # Application-wide shared configurations
│   │   ├── theme/                          # Theme and color configurations
│   │   │   ├── app_colors.dart
│   │   │   └── app_theme.dart
│   │   └── widgets/                        # Shared custom widgets
│   │       ├── app_button.dart
│   │       └── app_text_field.dart
│   │
│   ├── features/                           # Domain-specific feature modules
│   │   ├── auth/                           # Authentication feature
│   │   │   ├── data/
│   │   │   │   └── authrepo.dart           # Authentication logic & repository
│   │   │   └── ui/
│   │   │       └── login_signup_screen.dart # Login & Registration screen
│   │   │
│   │   ├── customer/                       # Customer flows
│   │   │   ├── screens/
│   │   │   │   ├── customer_home_screen.dart
│   │   │   │   ├── customer_main_layout.dart
│   │   │   │   ├── customer_notifications_screen.dart
│   │   │   │   ├── customer_profile_screen.dart
│   │   │   │   ├── order_tracking_screen.dart
│   │   │   │   ├── regular_booking_screen.dart
│   │   │   │   ├── tailor_profile_screen.dart
│   │   │   │   └── vip_booking_screen.dart
│   │   │   └── widgets/
│   │   │       ├── category_chip.dart
│   │   │       ├── order_timeline.dart
│   │   │       ├── status_tag.dart
│   │   │       └── tailor_card.dart
│   │   │
│   │   ├── onboarding/                     # App onboarding flow
│   │   │   ├── screens/
│   │   │   │   └── onboarding_screen.dart
│   │   │   └── widgets/
│   │   │       └── onboarding_page.dart
│   │   │
│   │   ├── splash/                         # App initialization screen
│   │   │   └── screens/
│   │   │       └── splash_screen.dart
│   │   │
│   │   └── tailor/                         # Vendor (Tailor) flows
│   │       ├── screens/
│   │       │   ├── menu_pricing_screen.dart
│   │       │   ├── orders_management_screen.dart
│   │       │   ├── queue_management_screen.dart
│   │       │   ├── tailor_dashboard_screen.dart
│   │       │   ├── tailor_earnings_screen.dart
│   │       │   ├── tailor_main_layout.dart
│   │       │   ├── tailor_order_details_screen.dart
│   │       │   ├── tailor_profile_settings.dart
│   │       │   ├── tailor_services_manager_screen.dart
│   │       │   └── tailor_settings_screen.dart
│   │       └── widgets/
│   │           ├── order_item_card.dart
│   │           ├── queue_ticket_card.dart
│   │           └── status_toggle_button.dart
│   │
│   ├── l10n/                               # Application localization dictionaries
│   │   ├── app_ar.arb                      # Master Arabic dictionary
│   │   ├── app_en.arb                      # Master English dictionary
│   │   ├── app_localizations.dart          # Generated base localization class
│   │   ├── app_localizations_ar.dart       # Generated Arabic localizations
│   │   └── app_localizations_en.dart       # Generated English localizations
│   │
│   └── main.dart                           # Root entry point and App widget
│
├── linux/                                  # Linux desktop build files
├── macos/                                  # macOS desktop build files
├── scratch/                                # Temporary/Scratch files directory
├── test/                                   # Unit and widget tests directory
├── web/                                    # Web build files
├── windows/                                # Windows desktop build files
│
├── .flutter-plugins-dependencies           # Generated list of plugin dependencies
├── .gitignore                              # Git ignored files configuration
├── .metadata                               # Flutter project metadata
├── analysis_options.yaml                   # Dart analyzer/linter configurations
├── ARCHITECTURE.md                         # Project architecture documentation
├── fix_errors.py                           # Python script for automating error fixes
├── fix_imports.py                          # Python script for sorting/fixing Dart imports
├── l10n.yaml                               # Localization code generation config
├── pubspec.lock                            # Dependency versions lock file
├── pubspec.yaml                            # Main project configuration and dependencies
├── README.md                               # Project readme file
├── tailor_shop.iml                         # IntelliJ/Android Studio project file
├── update_arb.py                           # Python script to update translation files
└── update_dart.py      
```

## Key Features Implemented

### 19 Distinct Screens
Built and interconnected a total of 19 high-fidelity screens spanning both user flows:
- **Vendor Flow:** Dashboard, Queue Management, Orders Management, Order Details, Shop Settings, and Menu/Pricing Screen.
- **Customer Flow:** Customer Home, Tailor Search, Tailor Profile (Services, Reviews), Regular Booking Form, VIP Home-Visit Booking Form, Order Tracking, Notifications, Checkout, Rating, and Customer Profile.
- **Shared/Core:** Splash Screen, and unified Login/Signup Gate.

### Robust Design System
- **`AppColors` & Theme:** A consistent "Navy, Gold, and White" color palette providing a premium feel.
- **Core Widgets:** Custom, highly-reusable components like `AppButton` and `AppTextField` guarantee UI consistency across all screens.
- **RTL Support:** Complete RTL (Right-to-Left) UI compatibility using `Icons.adaptive` and directional constraints.

### Comprehensive Localization
- **Setup:** Powered by `flutter_localizations` and configured via `l10n.yaml`.
- **Translations:** Fully centralized strings managed within English (`app_en.arb`) and Egyptian Arabic (`app_ar.arb`) dictionaries.
- **Dynamic Switching:** Users can dynamically change the app language from their Profile Settings (Customer) or Shop Settings (Tailor) via an elegant bottom sheet. The `TailorHubApp.setLocale` root method rebuilds the entire widget tree instantly without requiring an app restart.

## How to Run

1. **Prerequisites:** Ensure you have the Flutter SDK installed and an emulator/device ready.
2. **Dependencies:** Fetch project dependencies.
   ```bash
   flutter pub get
   ```
3. **Localization Generation:** If you add or modify any strings in the `.arb` files, you must regenerate the localization code:
   ```bash
   flutter gen-l10n
   ```
4. **Run the App:**
   ```bash
   flutter run
   ```
