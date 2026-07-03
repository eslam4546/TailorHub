import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TailorOrderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? orderData;

  const TailorOrderDetailsScreen({super.key, this.orderData});

  @override
  State<TailorOrderDetailsScreen> createState() =>
      _TailorOrderDetailsScreenState();
}

class _TailorOrderDetailsScreenState extends State<TailorOrderDetailsScreen> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();

    _currentStatus = widget.orderData?['status'] ?? 'New';
  }

  void _handleAccept() {
    setState(() {
      _currentStatus = 'In Progress';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✅ Order Accepted and moved to In Progress.'),
        backgroundColor: AppColors.statusAvailable,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleReject() {
    setState(() {
      _currentStatus = 'Rejected';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('❌ Order Rejected.'),
        backgroundColor: AppColors.statusClosed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleContactCustomer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening chat with customer...'),
        backgroundColor: AppColors.primaryNavy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String orderId = widget.orderData?['id'] ?? '#ORD-9021';
    final String customerName =
        widget.orderData?['customer'] ?? 'Youssef Ahmed';
    final String service =
        widget.orderData?['service'] ?? 'Formal Suit (Custom)';
    final String date = widget.orderData?['date'] ?? 'Today, 10:30 AM';
    final int price = widget.orderData?['price'] ?? 1500;
    final bool isVip = widget.orderData?['isVip'] ?? true;

    final int basePrice = isVip ? price - 200 : price;
    final int surcharge = isVip ? 200 : 0;

    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(orderId, _currentStatus, isVip),
            const SizedBox(height: 16),

            _buildCustomerCard(customerName),
            const SizedBox(height: 16),

            _buildOrderSpecsCard(service, date),
            const SizedBox(height: 16),

            _buildInstructionsCard(),
            const SizedBox(height: 16),

            _buildPriceBreakdownCard(basePrice, surcharge, price),
          ],
        ),
      ),

      bottomNavigationBar: _currentStatus == 'New'
          ? _buildActionBar()
          : const SizedBox.shrink(),
    );
  }

  Widget _buildHeaderCard(String orderId, String status, bool isVip) {
    Color statusColor;
    if (status == 'New')
      statusColor = AppColors.accentGold;
    else if (status == 'In Progress')
      statusColor = AppColors.primaryNavy;
    else if (status == 'Completed')
      statusColor = AppColors.statusAvailable;
    else
      statusColor = AppColors.statusClosed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        border: isVip
            ? Border.all(color: AppColors.accentGold, width: 2)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ID',
                style: TextStyle(fontSize: 12, color: AppColors.textLight),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  if (isVip) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'VIP',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(String customerName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryNavy.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.primaryNavy),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
                Text(
                  customerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: _handleContactCustomer,
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            color: AppColors.primaryNavy,
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryNavy.withValues(alpha: 0.05),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSpecsCard(String service, String date) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 18,
                color: AppColors.primaryNavy,
              ),
              SizedBox(width: 8),
              Text(
                'Order Specifications',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: AppColors.dividerGrey),
          ),
          _buildInfoRow('Service Type', service),
          const SizedBox(height: 12),
          _buildInfoRow('Requested Date', date),
        ],
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentGold.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.notes_rounded, size: 18, color: AppColors.accentGold),
              SizedBox(width: 8),
              Text(
                'Customer Notes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Please use a breathable Italian wool fabric. I need this urgently for a wedding next week.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textDark.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdownCard(int basePrice, int surcharge, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.payments_outlined,
                size: 18,
                color: AppColors.accentGold,
              ),
              SizedBox(width: 8),
              Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Colors.white24),
          ),
          _buildPriceRow('Base Price', '$basePrice EGP', isLight: true),
          if (surcharge > 0) ...[
            const SizedBox(height: 8),
            _buildPriceRow('VIP Surcharge', '$surcharge EGP', isLight: true),
          ],
          const SizedBox(height: 12),
          _buildPriceRow(
            'Total Payout',
            '$total EGP',
            isBold: true,
            color: AppColors.accentGold,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textMedium),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String value, {
    bool isLight = false,
    bool isBold = false,
    Color? color,
  }) {
    final textColor = color ?? (isLight ? Colors.white70 : AppColors.textWhite);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: _handleReject,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.statusClosed,
                  side: const BorderSide(color: AppColors.statusClosed),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Reject',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 2,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _handleAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: AppColors.textWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Accept Order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
