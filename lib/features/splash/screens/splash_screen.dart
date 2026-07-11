import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../customer/screens/customer_main_layout.dart';
import '../../tailor/screens/tailor_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // 1. استنى الـ 3 ثواني بتوع الشاشة الافتتاحية
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // 2. التحقق من حالة تسجيل الدخول الحالية
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // المستخدم مسجل دخول بالفعل، لازم نعرف دوره إيه
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          String? role = userDoc.get('role');

          if (!mounted) return;
          // توجيه بناءً على الدور
          if (role == 'tailor') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TailorDashboardScreen()),
            );
            return;
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const CustomerMainLayout()),
            );
            return;
          }
        }
      } catch (e) {
        // لو حصل خطأ في جلب البيانات، نتجاهله ونكمل للشاشة العادية
        debugPrint("Error fetching user role: $e");
      }
    }

    if (!mounted) return;
    // 3. لو مفيش مستخدم مسجل، نوديه لشاشة الـ Onboarding
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy,

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.content_cut_rounded,
                    size: 64,
                    color: AppColors.accentGold,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    AppLocalizations.of(context)!.tailorHub,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                      letterSpacing: 2.0,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    AppLocalizations.of(context)!.yourTailorOneTapAway,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textWhite.withValues(alpha: 0.7),
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                minHeight: 4,
                backgroundColor: AppColors.textWhite.withValues(alpha: 0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.accentGold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
