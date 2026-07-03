import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import 'tailor_profile_settings.dart';
import 'queue_management_screen.dart';
import 'orders_management_screen.dart';

class TailorDashboardScreen extends StatefulWidget {
  const TailorDashboardScreen({super.key});

  @override
  State<TailorDashboardScreen> createState() => _TailorDashboardScreenState();
}

class _TailorDashboardScreenState extends State<TailorDashboardScreen> {
  String _activeStatusKey = 'statusAvailable';

  final int _peopleInQueue = 5;
  final int _activeOrders = 12;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final localeName = Localizations.localeOf(context).languageCode;
    final String todayDate = DateFormat(
      'EEEE, d MMMM',
      localeName,
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(l10n.vendorDashboard),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.storefront_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TailorProfileSettings(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.welcomeShopManager,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              todayDate,
              style: const TextStyle(fontSize: 14, color: AppColors.textMedium),
            ),
            const SizedBox(height: 32),

            Text(
              l10n.shopStatus,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusGrid(l10n),

            const SizedBox(height: 32),

            Text(
              l10n.realTimeOverview,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            _buildOverviewCard(
              title: l10n.peopleInQueue,
              value: _peopleInQueue,
              icon: Icons.people_alt_rounded,
              iconColor: AppColors.primaryNavy,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QueueManagementScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildOverviewCard(
              title: l10n.activeOrders,
              value: _activeOrders,
              icon: Icons.inventory_2_rounded,
              iconColor: AppColors.accentGold,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrdersManagementScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusGrid(AppLocalizations l10n) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatusCard(
          l10n: l10n,
          statusKey: 'statusAvailable',
          label: l10n.statusAvailable,
          icon: Icons.check_circle_outline_rounded,
          activeColor: AppColors.statusAvailable,
        ),
        _buildStatusCard(
          l10n: l10n,
          statusKey: 'statusBusy',
          label: l10n.statusBusy,
          icon: Icons.access_time_rounded,
          activeColor: AppColors.statusBusy,
        ),
        _buildStatusCard(
          l10n: l10n,
          statusKey: 'statusPrayer',
          label: l10n.statusPrayer,
          icon: Icons.mosque_outlined,
          activeColor: AppColors.primaryNavy,
        ),
        _buildStatusCard(
          l10n: l10n,
          statusKey: 'statusClosed',
          label: l10n.statusStop,
          icon: Icons.stop_circle_outlined,
          activeColor: AppColors.statusClosed,
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required AppLocalizations l10n,
    required String statusKey,
    required String label,
    required IconData icon,
    required Color activeColor,
  }) {
    final bool isActive = _activeStatusKey == statusKey;

    return GestureDetector(
      onTap: () {
        setState(() {
          _activeStatusKey = statusKey;
        });

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.statusUpdateFeedback(label)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.1)
              : AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? activeColor : AppColors.dividerGrey,
            width: isActive ? 2 : 1,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: activeColor.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: AppColors.primaryNavy.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: isActive ? activeColor : AppColors.textMedium,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? activeColor : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required int value,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
