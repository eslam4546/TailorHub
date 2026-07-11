import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import 'tailor_dashboard_screen.dart';
import 'queue_management_screen.dart';
import 'tailor_earnings_screen.dart';
import 'tailor_profile_settings.dart';

class TailorMainLayout extends StatefulWidget {
  const TailorMainLayout({super.key});

  @override
  State<TailorMainLayout> createState() => _TailorMainLayoutState();
}

class _TailorMainLayoutState extends State<TailorMainLayout> {
  int _currentIndex = 0;

  // قائمة الشاشات اللي الترزي هيتنقل بينها في الشريط السفلي
  final List<Widget> _screens = const [
    TailorDashboardScreen(),
    QueueManagementScreen(),
    TailorEarningsScreen(),
    TailorProfileSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      // استخدام IndexedStack هنا عبقري عشان يحافظ على حالة كل شاشة (State) والـ Scroll وميعيدش تحميل الداتا
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -4), // ظل ناعم متجه لأعلى ليفصل الشريط عن الشاشة
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backgroundWhite,
          selectedItemColor: AppColors.primaryNavy,
          unselectedItemColor: AppColors.textLight,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            height: 1.8,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            height: 1.8,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_outlined),
              activeIcon: const Icon(Icons.dashboard_rounded),
              label: l10n.navHome, // أو الكي المقابل للرئيسية عندك
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.people_outline_rounded),
              activeIcon: const Icon(Icons.people_rounded),
              label: l10n.queueManagement,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance_wallet_outlined),
              activeIcon: const Icon(Icons.account_balance_wallet_rounded),
              label: 'الأرباح', // أو l10n.earnings لو جاهزة في الـ .arb
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.storefront_outlined),
              activeIcon: const Icon(Icons.storefront_rounded),
              label: l10n.shopSettings,
            ),
          ],
        ),
      ),
    );
  }
}