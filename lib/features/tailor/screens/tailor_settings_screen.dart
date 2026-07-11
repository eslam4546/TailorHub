import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class TailorSettingsScreen extends StatelessWidget {
  const TailorSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(l10n.shopSettings), // أو الكي المخصص للإعدادات العامة عندك
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildSettingsGroup(
            title: 'Account Settings',
            children: [
              _buildSettingsTile(
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile Info',
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),
              _buildSettingsTile(
                icon: Icons.security_rounded,
                title: 'Privacy & Security',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSettingsGroup(
            title: 'General Settings',
            children: [
              _buildSettingsTile(
                icon: Icons.notifications_none_rounded,
                title: l10n.notifications,
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),
              _buildSettingsTile(
                icon: Icons.g_translate_rounded,
                title: l10n.appLanguage,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildSettingsGroup(
            title: 'Support & Legal',
            children: [
              _buildSettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.dividerGrey, indent: 56),
              _buildSettingsTile(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textMedium,
            ),
          ),
        ),
        Container(
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
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryNavy.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primaryNavy, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textLight,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}