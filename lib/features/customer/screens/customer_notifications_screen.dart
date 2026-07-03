import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class CustomerNotificationsScreen extends StatelessWidget {
  const CustomerNotificationsScreen({super.key});

  List<Map<String, dynamic>> _getMockNotifications(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'title': l10n.orderReadyTitle,
        'message': l10n.orderReadyMessage,
        'time': l10n.justNow,
        'isUnread': true,
        'type': 'order_completed',
      },
      {
        'title': l10n.newMessageTitle,
        'message': l10n.newMessageMessage,
        'time': l10n.hoursAgo,
        'isUnread': true,
        'type': 'message',
      },
      {
        'title': l10n.orderInProgressTitle,
        'message': l10n.orderInProgressMessage,
        'time': l10n.dayAgo,
        'isUnread': false,
        'type': 'order_update',
      },
      {
        'title': l10n.vipBookingConfirmedTitle,
        'message': l10n.vipBookingConfirmedMessage,
        'time': l10n.daysAgo,
        'isUnread': false,
        'type': 'vip_booking',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: _getMockNotifications(context).isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _getMockNotifications(context).length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                color: AppColors.dividerGrey,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                return _NotificationTile(
                  notification: _getMockNotifications(context)[index],
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noNotificationsYet,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.noNotificationsDesc,
            style: const TextStyle(fontSize: 14, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final Map<String, dynamic> notification;

  const _NotificationTile({required this.notification});

  IconData _getIconForType(String type) {
    switch (type) {
      case 'order_completed':
        return Icons.check_circle_outline_rounded;
      case 'order_update':
        return Icons.inventory_2_outlined;
      case 'message':
        return Icons.chat_bubble_outline_rounded;
      case 'vip_booking':
        return Icons.star_outline_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getIconColorForType(String type) {
    switch (type) {
      case 'order_completed':
        return AppColors.statusAvailable;
      case 'vip_booking':
        return AppColors.accentGold;
      default:
        return AppColors.primaryNavy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUnread = notification['isUnread'];
    final String title = notification['title'];
    final String message = notification['message'];
    final String time = notification['time'];
    final String type = notification['type'];

    return InkWell(
      onTap: () {},
      child: Container(
        color: isUnread
            ? AppColors.primaryNavy.withValues(alpha: 0.04)
            : AppColors.backgroundWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 12,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 6),
              child: isUnread
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGold,
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(width: 8),

            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _getIconColorForType(type).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForType(type),
                color: _getIconColorForType(type),
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                      ),

                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnread
                              ? AppColors.primaryNavy
                              : AppColors.textLight,
                          fontWeight: isUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMedium,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
