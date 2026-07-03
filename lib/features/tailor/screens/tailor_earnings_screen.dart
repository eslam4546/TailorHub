import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TailorEarningsScreen extends StatefulWidget {
  const TailorEarningsScreen({super.key});

  @override
  State<TailorEarningsScreen> createState() => _TailorEarningsScreenState();
}

class _TailorEarningsScreenState extends State<TailorEarningsScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'ORD-9018',
      'service': 'Custom Pants',
      'date': '10 Jul 2025',
      'amount': 400,
      'isManual': false,
    },
    {
      'id': 'MAN-0102',
      'service': 'Dress Hemming',
      'date': '09 Jul 2025',
      'amount': 150,
      'isManual': true,
    },
    {
      'id': 'ORD-8802',
      'service': 'Formal Suit',
      'date': '05 Jul 2025',
      'amount': 1500,
      'isManual': false,
    },
  ];

  int get _appIncome => _transactions
      .where((t) => !t['isManual'])
      .fold<int>(0, (sum, t) => sum + (t['amount'] as int));

  int get _manualIncome => _transactions
      .where((t) => t['isManual'])
      .fold<int>(0, (sum, t) => sum + (t['amount'] as int));

  int get _totalIncome => _appIncome + _manualIncome;

  void _showAddManualEntryModal() {
    final TextEditingController serviceController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Manual Entry',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: serviceController,
                decoration: const InputDecoration(
                  labelText: 'Service Type (e.g. Alteration)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount (EGP)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final service = serviceController.text.trim();
                    final amount =
                        int.tryParse(amountController.text.trim()) ?? 0;

                    if (service.isNotEmpty && amount > 0) {
                      setState(() {
                        _transactions.insert(0, {
                          'id':
                              'MAN-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
                          'service': service,
                          'date': 'Today',
                          'amount': amount,
                          'isManual': true,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: AppColors.textWhite,
                  ),
                  child: const Text('Save Entry'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: const Text('Earnings'),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummaryCard(),
          const SizedBox(height: 24),
          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
          const SizedBox(height: 12),
          ..._transactions.map((txn) => _buildTransactionCard(txn)),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddManualEntryModal,
        backgroundColor: AppColors.accentGold,
        icon: const Icon(Icons.add, color: AppColors.primaryNavy),
        label: const Text(
          'Manual Entry',
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Earnings',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '$_totalIncome EGP',
            style: const TextStyle(
              color: AppColors.accentGold,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white24, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'App Orders',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_appIncome EGP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Manual Cash',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_manualIncome EGP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> txn) {
    final bool isManual = txn['isManual'];
    final int amount = txn['amount'];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: AppColors.backgroundWhite,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isManual
              ? AppColors.accentGold.withValues(alpha: 0.2)
              : AppColors.primaryNavy.withValues(alpha: 0.1),
          child: Icon(
            isManual ? Icons.point_of_sale_rounded : Icons.app_shortcut_rounded,
            color: isManual ? AppColors.accentGold : AppColors.primaryNavy,
          ),
        ),
        title: Text(
          txn['service'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          '${txn['date']} • ${isManual ? "Manual Entry" : "App Order"}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text(
          '+$amount EGP',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: AppColors.statusAvailable,
          ),
        ),
      ),
    );
  }
}
