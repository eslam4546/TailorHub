import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/ui/login_signup_screen.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';
import '../../../main.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  static const String _customerName = 'Youssef Ahmed';
  static const String _customerEmail = 'youssef.ahmed@example.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myProfile),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 32),

            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryNavy.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.accentGold, width: 2),
            ),
            child: const Center(
              child: Text(
                'Y',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            _customerName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),

          const Text(
            _customerEmail,
            style: TextStyle(fontSize: 14, color: AppColors.textMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person_outline_rounded,
            title: AppLocalizations.of(context)!.myAccount,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),

          _buildMenuItem(
            icon: Icons.credit_card_rounded,
            title: AppLocalizations.of(context)!.paymentMethods,
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),

          _buildMenuItem(
            icon: Icons.help_outline_rounded,
            title: AppLocalizations.of(context)!.helpAndSupport,
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.language_rounded,
            title: AppLocalizations.of(context)!.appLanguage,
            onTap: () => _showLanguageBottomSheet(context),
          ),
          const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),

          _buildMenuItem(
            icon: Icons.logout_rounded,
            title: AppLocalizations.of(context)!.logOut,
            iconColor: AppColors.statusClosed,
            textColor: AppColors.statusClosed,
            hideTrailingArrow: true,
            onTap: () {
              _showLogoutConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppColors.primaryNavy,
    Color textColor = AppColors.textDark,
    bool hideTrailingArrow = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      trailing: hideTrailingArrow
          ? null
          : const Icon(Icons.chevron_right_rounded, color: AppColors.textLight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(AppLocalizations.of(context)!.logOut),
          content: Text(
            AppLocalizations.of(context)!.logOutConfirmationContent,
          ),
          actions: [
            AppButton(
              onPressed: () => Navigator.of(context).pop(),
              text: AppLocalizations.of(context)!.cancel,
              type: AppButtonType.text,
              isFullWidth: false,
            ),
            AppButton(
              onPressed: () async {
                // 1. قفل الـ Dialog
                Navigator.of(context).pop();

                // 2. تسجيل الخروج الفعلي من فايربيز
                await FirebaseAuth.instance.signOut();

                if (!context.mounted) return;

                // 3. التوجيه لشاشة تسجيل الدخول
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen(),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
              text: AppLocalizations.of(context)!.logOut,
              isFullWidth: false,
            ),
          ],
        );
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.appLanguage,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: AppColors.primaryNavy,
                  ),
                  title: const Text(
                    'English',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: Localizations.localeOf(context).languageCode == 'en'
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.statusAvailable,
                        )
                      : null,
                  onTap: () {
                    TailorHubApp.setLocale(context, const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  height: 1,
                  color: AppColors.dividerGrey,
                  indent: 56,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: AppColors.primaryNavy,
                  ),
                  title: const Text(
                    'العربية',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: Localizations.localeOf(context).languageCode == 'ar'
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.statusAvailable,
                        )
                      : null,
                  onTap: () {
                    TailorHubApp.setLocale(context, const Locale('ar'));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
