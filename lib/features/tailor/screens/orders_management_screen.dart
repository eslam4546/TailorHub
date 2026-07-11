import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/order_item_card.dart';

class OrdersManagementScreen extends StatefulWidget {
  const OrdersManagementScreen({super.key});

  @override
  State<OrdersManagementScreen> createState() => _OrdersManagementScreenState();
}

class _OrdersManagementScreenState extends State<OrdersManagementScreen> {
  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'Order #1042',
      'service': 'Custom Navy Suit',
      'customer': 'Julian Reed',
      'statusKey': 'inProduction',
    },
    {
      'id': 'Order #1043',
      'service': 'Dress Hemming',
      'customer': 'Fatma Al-Zahraa',
      'statusKey': 'inProduction',
    },
    {
      'id': 'Order #1044',
      'service': 'Jacket Lining Repair',
      'customer': 'Omar Youssef',
      'statusKey': 'finalFitting',
    },
  ];

  void _markReadyForPickup(Map<String, dynamic> order, AppLocalizations l10n) {
    setState(() {
      _activeOrders.removeWhere((o) => o['id'] == order['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.orderReadyFeedback(order['id'])),
        backgroundColor: AppColors.statusAvailable,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(l10n.ordersManagement),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: _activeOrders.isEmpty
          ? _buildEmptyState(l10n)
          : ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: _activeOrders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: OrderItemCard(
                    order: _activeOrders[index],
                    l10n: l10n,
                    onMarkReady: () =>
                        _markReadyForPickup(_activeOrders[index], l10n),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noActiveOrders,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
