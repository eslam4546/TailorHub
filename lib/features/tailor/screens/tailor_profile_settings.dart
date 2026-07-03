import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/screens/login_signup_screen.dart';
import 'menu_pricing_screen.dart';

class TailorProfileSettings extends StatefulWidget {
  const TailorProfileSettings({super.key});

  @override
  State<TailorProfileSettings> createState() => _TailorProfileSettingsState();
}

class _TailorProfileSettingsState extends State<TailorProfileSettings> {
  String _specialization = "Both";
  bool _acceptCash = true;

  final TextEditingController _instapayController = TextEditingController(
    text: "ahmed.tailor@instapay",
  );
  final TextEditingController _ewalletController = TextEditingController(
    text: "01012345678",
  );

  @override
  void dispose() {
    _instapayController.dispose();
    _ewalletController.dispose();
    super.dispose();
  }

  void _handleLogout() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(l10n.logOut),
          content: Text(l10n.logOutConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: AppColors.textMedium),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginSignupScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.statusClosed,
                foregroundColor: AppColors.textWhite,
              ),
              child: Text(l10n.logOut),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.appLanguage,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('English'),
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
              const Divider(height: 1, color: AppColors.dividerGrey),
              ListTile(
                title: const Text('العربية (Egyptian Arabic)'),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final currentLanguageCode = Localizations.localeOf(context).languageCode;
    final displayLanguage = currentLanguageCode == 'ar' ? 'العربية' : 'English';

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(l10n.shopSettings),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(l10n),
            const SizedBox(height: 24),

            _buildSectionHeader(l10n.businessSettings),
            _buildCardGroup(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.receipt_long_rounded,
                    color: AppColors.primaryNavy,
                  ),
                  title: Text(
                    l10n.manageServicesPricing,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMedium,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuPricingScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(l10n.shopSpecialization),
            _buildCardGroup(
              children: [
                _buildRadioTile(l10n.mensFashion),
                const Divider(height: 1, color: AppColors.dividerGrey),
                _buildRadioTile(l10n.womensFashion),
                const Divider(height: 1, color: AppColors.dividerGrey),
                _buildRadioTile(l10n.bothFashion),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(l10n.paymentMethods),
            _buildCardGroup(
              padding: const EdgeInsets.all(16),
              children: [
                AppTextField(
                  labelText: l10n.instapayHandle,
                  controller: _instapayController,
                  prefixIcon: Icons.alternate_email_rounded,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  labelText: l10n.ewalletVodafoneCash,
                  controller: _ewalletController,
                  prefixIcon: Icons.phone_iphone_rounded,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      l10n.acceptCashInShop,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    activeColor: AppColors.statusAvailable,
                    value: _acceptCash,
                    onChanged: (val) {
                      setState(() {
                        _acceptCash = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionHeader(l10n.appSettings),
            _buildCardGroup(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.language_rounded,
                    color: AppColors.primaryNavy,
                  ),
                  title: Text(
                    l10n.appLanguage,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayLanguage,
                        style: const TextStyle(color: AppColors.textMedium),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textMedium,
                      ),
                    ],
                  ),
                  onTap: _showLanguageBottomSheet,
                ),
                const Divider(height: 1, color: AppColors.dividerGrey),
                ListTile(
                  leading: const Icon(
                    Icons.notifications_active_rounded,
                    color: AppColors.primaryNavy,
                  ),
                  title: Text(
                    l10n.notifications,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(height: 1, color: AppColors.dividerGrey),
                ListTile(
                  leading: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primaryNavy,
                  ),
                  title: Text(
                    l10n.helpSupport,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMedium,
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            Center(
              child: TextButton.icon(
                onPressed: _handleLogout,
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.statusClosed,
                ),
                label: Text(
                  l10n.logOut,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.statusClosed,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AppLocalizations l10n) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryNavy.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryNavy, width: 2),
          ),
          child: const Center(
            child: Icon(
              Icons.storefront_rounded,
              size: 32,
              color: AppColors.primaryNavy,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Master Tailor Ahmed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: () {},
                child: Text(
                  l10n.editProfile,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentGold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textMedium,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCardGroup({
    required List<Widget> children,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Container(
      padding: padding,
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
      child: Column(children: children),
    );
  }

  Widget _buildRadioTile(String value) {
    return RadioListTile<String>(
      title: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      value: value,
      groupValue: _specialization,
      activeColor: AppColors.primaryNavy,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _specialization = newValue;
          });
        }
      },
    );
  }
}
