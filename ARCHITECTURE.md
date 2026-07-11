# TailorHub: Technical Architecture & Master Reference

This document serves as the master technical reference for the **TailorHub** project. It outlines the structural design, directory conventions, design system mechanics, state management approach, and localization workflow. It is designed to rapidly onboard any new developer or AI agent to the current codebase state.

---

## 1. Project Dependencies

The project relies on a carefully selected set of core dependencies declared in `pubspec.yaml`:

| Package | Version | Purpose & Role |
|---------|---------|----------------|
| `flutter` | `sdk` | The core UI framework. |
| `flutter_localizations` | `sdk` | Provides native widget localizations and RTL support. Essential for Arabic (Egyptian) layouts. |
| `intl` | `^0.20.2` | Core internationalization library. **Note:** Pinned strictly to `0.20.2` due to compatibility constraints with the current Flutter SDK version. Upgrading to `0.20.3` causes build failures. |
| `cupertino_icons` | `^1.0.8` | Standard iOS style icons. |

*Note: Firebase SDKs (Auth, Firestore, Core) are not yet installed and are part of the next development phase.*

---

## 2. Design System Details

The UI is built on a strict, centralized design system to ensure aesthetic consistency and code reusability.

### A. Color Palette (`AppColors`)
Located in `lib/core/theme/app_colors.dart`.
- **Primary:** `primaryNavy` - Used for AppBars, primary buttons, and active states.
- **Accent:** `accentGold` - Used for highlights, VIP components, and active indicators.
- **Backgrounds:** `backgroundWhite` (cards, bottom sheets) and `surfaceGrey` (scaffold backgrounds).
- **Text:** `textDark`, `textMedium`, `textLight`, and `textWhite`.
- **Status:** `statusAvailable` (Green), `statusBusy` (Orange), `statusClosed` (Red).

### B. Shared Components
Located in `lib/core/widgets/`. Always use these instead of raw Material widgets.
- **`AppButton` (`app_button.dart`):** 
  - Standardized custom button with `primary` (Navy background/White text) and `secondary/outlined` (White background/Navy border) variants.
  - Built-in `isLoading` state handling (displays a `CircularProgressIndicator`).
  - Strict 12dp border radius implementation.
- **`AppTextField` (`app_text_field.dart`):**
  - Standardized text input with custom `OutlineInputBorder` mechanics (Navy on focus, subtle Grey otherwise).
  - Supports prefix/suffix icons and adheres to `AppColors` for hints and input text.

---

## 3. Feature-First Directory Structure

We use a scalable **Feature-First** architecture. Every domain gets its own self-contained folder.

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
└── update_dart.py                          # Python script to update dart files
```

*Rule: Cross-feature imports should be minimized. Features should primarily interact through routing or core services.*

---

## 4. Localization Workflow

The app uses `flutter_gen` dynamically to generate strongly-typed localization delegates. The configuration is defined in `l10n.yaml`.

**To add or modify strings:**
1. Open `lib/l10n/app_en.arb` and add a new key-value pair (e.g., `"newKey": "English Text"`).
2. Open `lib/l10n/app_ar.arb` and add the *exact same key* with the Arabic translation (e.g., `"newKey": "النص العربي"`).
3. Run the generator in the terminal:
   ```bash
   flutter gen-l10n
   ```
4. Access the string in any widget using:
   ```dart
   AppLocalizations.of(context)!.newKey
   ```
   *(Ensure `import 'package:tailor_shop/l10n/app_localizations.dart';` is present at the top of the file).*

---

## 5. State Management & Locale

Currently, state management is largely handled by standard `StatefulWidget` mechanics.

**Dynamic Language Switching:**
1. **The State:** `main.dart` contains `TailorHubApp` (a `StatefulWidget`). It holds a `Locale? _locale` variable.
2. **The Injector:** The `MaterialApp` is configured with `localizationsDelegates`, `supportedLocales`, and `locale: _locale`.
3. **The Mutator:** A static method `TailorHubApp.setLocale(BuildContext context, Locale newLocale)` allows child widgets to update the root state.
4. **The Trigger:** When a user selects a language in `customer_profile_screen.dart` or `tailor_profile_settings.dart`, `setLocale` is called. This triggers a root-level `setState()`, rebuilding the entire widget tree instantly to reflect the new language and RTL layout without requiring an app restart.

---

## 6. Navigation & Routing

The application relies on declarative Material page routing (`Navigator.push`, `Navigator.pushReplacement`).
- **Entry:** `SplashScreen` acts as the initial loading interface.
- **Gate:** `LoginSignupScreen` acts as the router split. Based on the selected role ("Customer" vs "Tailor Shop"), the user is routed to either:
  - `CustomerMainLayout` (Bottom Navigation wrapper for the Customer flow)
  - `TailorDashboardScreen` (Main Entry point for the Vendor flow)

---

## 7. TODOs & Next Steps

### Phase 1: Backend Integration (Immediate Next Steps)
- [ ] **Firebase Initialization:** Configure `firebase_core` and initialize the project for iOS/Android platforms.
- [ ] **Authentication:** Implement `firebase_auth` in `LoginSignupScreen` for real user registration and login.
- [ ] **Database Modeling:** Design Firestore (or Firebase Data Connect) schemas for `Users`, `Shops`, `Orders`, and `Services`.
- [ ] **Service Layer:** Create isolated repository classes (e.g., `AuthService`, `OrderService`) in `lib/core/services/` to handle backend communication, replacing all hardcoded mock data currently in the UI files.

### Phase 2: Polish & Advanced Features
- [ ] **State Management Library:** Introduce Provider, Riverpod, or Bloc if state/dependency complexity scales beyond basic `StatefulWidget` limits.
- [ ] **Push Notifications:** Integrate Firebase Cloud Messaging (FCM) to update customers dynamically on order status changes.
- [ ] **Payment Integration:** Implement actual backend verification for the "InstaPay/Vodafone Cash" flow inside the placeholder `CheckoutScreen`.
