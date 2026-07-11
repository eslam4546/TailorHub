import os

def replace_in_file(filepath, target, replacement):
    with open(filepath, 'r') as f:
        content = f.read()
    content = content.replace(target, replacement)
    with open(filepath, 'w') as f:
        f.write(content)
        
def split_and_extract(filepath, split_str, import_stmt, class_name):
    with open(filepath, 'r') as f:
        content = f.read()
    if split_str in content:
        parts = content.split(split_str)
        screen_code = parts[0]
        # remove trailing spaces/newlines
        screen_code = screen_code.rstrip() + '\n'
        
        # add import
        if "import '../../../l10n/app_localizations.dart';" in screen_code:
             screen_code = screen_code.replace("import '../../../l10n/app_localizations.dart';", "import '../../../l10n/app_localizations.dart';\n" + import_stmt)
        elif "import 'package:tailor_shop/l10n/app_localizations.dart';" in screen_code:
             screen_code = screen_code.replace("import 'package:tailor_shop/l10n/app_localizations.dart';", "import 'package:tailor_shop/l10n/app_localizations.dart';\n" + import_stmt)
        
        # fix occurrences
        screen_code = screen_code.replace(f"_{class_name}(", f"{class_name}(")
        with open(filepath, 'w') as f:
            f.write(screen_code)

# 1. queue_management_screen
split_and_extract(
    'lib/features/tailor/screens/queue_management_screen.dart', 
    'class _QueueTicketCard extends StatelessWidget {',
    "import '../widgets/queue_ticket_card.dart';",
    "QueueTicketCard"
)

# 2. orders_management_screen
split_and_extract(
    'lib/features/tailor/screens/orders_management_screen.dart', 
    'class _OrderProductionCard extends StatelessWidget {',
    "import '../widgets/order_item_card.dart';",
    "OrderProductionCard"
)
replace_in_file(
    'lib/features/tailor/screens/orders_management_screen.dart',
    "_OrderProductionCard(", "OrderItemCard("
)

# 3. order_tracking_screen
split_and_extract(
    'lib/features/customer/screens/order_tracking_screen.dart', 
    'class _OrderTimeline extends StatelessWidget {',
    "import '../widgets/order_timeline.dart';",
    "OrderTimeline"
)
order_tracking = open('lib/features/customer/screens/order_tracking_screen.dart').read()
if "import '../widgets/order_timeline.dart';" in order_tracking:
    order_tracking = order_tracking.replace("import '../widgets/order_timeline.dart';", "import '../widgets/order_timeline.dart';\nimport '../widgets/status_tag.dart';")

target_status = """
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
"""
replacement_status = """
              StatusTag(
                status: status,
                color: statusColor,
                hasBackground: true,
              ),
"""
if target_status.strip('\n') in order_tracking:
    order_tracking = order_tracking.replace(target_status.strip('\n'), replacement_status.strip('\n'))
with open('lib/features/customer/screens/order_tracking_screen.dart', 'w') as f:
    f.write(order_tracking)

# 4. tailor_dashboard_screen
dashboard = open('lib/features/tailor/screens/tailor_dashboard_screen.dart').read()
dashboard = dashboard.replace("import 'orders_management_screen.dart';", "import 'orders_management_screen.dart';\nimport '../widgets/status_toggle_button.dart';")
target_build_status_card = """
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
"""
replacement_method = """
  void _updateStatus(String statusKey, String label, AppLocalizations l10n) {
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
  }
"""
if target_build_status_card.strip('\n') in dashboard:
    dashboard = dashboard.replace(target_build_status_card.strip('\n'), replacement_method.strip('\n'))
dashboard = dashboard.replace("_buildStatusCard(\n          l10n: l10n,\n          statusKey: 'statusAvailable',\n          label: l10n.statusAvailable,\n          icon: Icons.check_circle_outline_rounded,\n          activeColor: AppColors.statusAvailable,\n        )", "StatusToggleButton(\n          label: l10n.statusAvailable,\n          icon: Icons.check_circle_outline_rounded,\n          activeColor: AppColors.statusAvailable,\n          isActive: _activeStatusKey == 'statusAvailable',\n          onTap: () => _updateStatus('statusAvailable', l10n.statusAvailable, l10n),\n        )")
dashboard = dashboard.replace("_buildStatusCard(\n          l10n: l10n,\n          statusKey: 'statusBusy',\n          label: l10n.statusBusy,\n          icon: Icons.access_time_rounded,\n          activeColor: AppColors.statusBusy,\n        )", "StatusToggleButton(\n          label: l10n.statusBusy,\n          icon: Icons.access_time_rounded,\n          activeColor: AppColors.statusBusy,\n          isActive: _activeStatusKey == 'statusBusy',\n          onTap: () => _updateStatus('statusBusy', l10n.statusBusy, l10n),\n        )")
dashboard = dashboard.replace("_buildStatusCard(\n          l10n: l10n,\n          statusKey: 'statusPrayer',\n          label: l10n.statusPrayer,\n          icon: Icons.mosque_outlined,\n          activeColor: AppColors.primaryNavy,\n        )", "StatusToggleButton(\n          label: l10n.statusPrayer,\n          icon: Icons.mosque_outlined,\n          activeColor: AppColors.primaryNavy,\n          isActive: _activeStatusKey == 'statusPrayer',\n          onTap: () => _updateStatus('statusPrayer', l10n.statusPrayer, l10n),\n        )")
dashboard = dashboard.replace("_buildStatusCard(\n          l10n: l10n,\n          statusKey: 'statusClosed',\n          label: l10n.statusStop,\n          icon: Icons.stop_circle_outlined,\n          activeColor: AppColors.statusClosed,\n        )", "StatusToggleButton(\n          label: l10n.statusStop,\n          icon: Icons.stop_circle_outlined,\n          activeColor: AppColors.statusClosed,\n          isActive: _activeStatusKey == 'statusClosed',\n          onTap: () => _updateStatus('statusClosed', l10n.statusStop, l10n),\n        )")
with open('lib/features/tailor/screens/tailor_dashboard_screen.dart', 'w') as f:
    f.write(dashboard)

# 5. customer_home_screen
home = open('lib/features/customer/screens/customer_home_screen.dart').read()
if "import 'tailor_profile_screen.dart';" in home:
    home = home.replace("import 'tailor_profile_screen.dart';", "import 'tailor_profile_screen.dart';\nimport '../widgets/category_chip.dart';\nimport '../widgets/tailor_card.dart';")

target_choice_chip = """
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = index;
                });
              },
              selectedColor: AppColors.primaryNavy,
              backgroundColor: AppColors.surfaceGrey,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.textWhite : AppColors.textDark,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryNavy
                      : AppColors.dividerGrey,
                ),
              ),
            ),
"""
replacement_choice_chip = """
            child: CategoryChip(
              label: categories[index],
              isSelected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = index;
                });
              },
            ),
"""
if target_choice_chip.strip('\n') in home:
    home = home.replace(target_choice_chip.strip('\n'), replacement_choice_chip.strip('\n'))

target_tailor_card = """
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TailorProfileScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 40,
                      color: AppColors.primaryNavy.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tailor['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryNavy,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.accentGold,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                tailor['rating'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: AppColors.textMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tailor['distance'],
                            style: const TextStyle(
                              color: AppColors.textMedium,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              translatedSpecialty,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryNavy,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tailor['services'],
                              style: const TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isAvailable
                                      ? AppColors.statusAvailable
                                      : AppColors.statusClosed,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                translatedStatus,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isAvailable
                                      ? AppColors.statusAvailable
                                      : AppColors.statusClosed,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
"""

replacement_tailor_card = """
        return TailorCard(
          tailor: tailor,
          translatedStatus: translatedStatus,
          translatedSpecialty: translatedSpecialty,
          isAvailable: isAvailable,
        );
"""

if target_tailor_card.strip('\n') in home:
    home = home.replace(target_tailor_card.strip('\n'), replacement_tailor_card.strip('\n'))
with open('lib/features/customer/screens/customer_home_screen.dart', 'w') as f:
    f.write(home)

# 6. regular_booking_screen
reg_booking = open('lib/features/customer/screens/regular_booking_screen.dart').read()
if "import 'package:tailor_shop/l10n/app_localizations.dart';" in reg_booking:
    reg_booking = reg_booking.replace("import 'package:tailor_shop/l10n/app_localizations.dart';", "import 'package:tailor_shop/l10n/app_localizations.dart';\nimport '../widgets/status_tag.dart';")
target_reg = """
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.statusAvailable.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 7, color: AppColors.statusAvailable),
                SizedBox(width: 5),
                Text(
                  'متاح',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.statusAvailable,
                  ),
                ),
              ],
            ),
          ),
"""
replacement_reg = """
          const StatusTag(
            status: 'متاح',
            color: AppColors.statusAvailable,
            showDot: true,
            hasBackground: true,
          ),
"""
if target_reg.strip('\n') in reg_booking:
    reg_booking = reg_booking.replace(target_reg.strip('\n'), replacement_reg.strip('\n'))
with open('lib/features/customer/screens/regular_booking_screen.dart', 'w') as f:
    f.write(reg_booking)
