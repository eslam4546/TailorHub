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
lib/
├── core/
│   ├── theme/          # AppColors, Typography, Themes
│   └── widgets/        # Reusable shared UI components (AppButton, AppTextField)
├── features/
│   ├── auth/           # Login & Registration flows
│   ├── customer/       # Customer-specific screens & logic
│   ├── splash/         # Splash screen and initialization
│   └── tailor/         # Vendor/Tailor-specific screens & logic
├── l10n/               # Localization ARB files (app_en.arb, app_ar.arb)
└── main.dart           # App Entry Point & Dynamic Locale Manager
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
