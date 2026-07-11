import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart'; // الإضافة الأولى: المكتبة الأساسية
import 'firebase_options.dart'; // الإضافة التانية: ملف الإعدادات الخاص بمشروعك

import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  // 1. التأكد من ربط فلاتر بالنظام
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تشغيل فايربيز بالإعدادات الصح
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TailorHubApp());
}


class TailorHubApp extends StatefulWidget {
  const TailorHubApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _TailorHubAppState? state = context
        .findAncestorStateOfType<_TailorHubAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<TailorHubApp> createState() => _TailorHubAppState();
}

class _TailorHubAppState extends State<TailorHubApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TailorHub',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('ar', '')],

      home: const SplashScreen(),
    );
  }
}
