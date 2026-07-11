import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/queue_ticket_card.dart';

class QueueManagementScreen extends StatefulWidget {
  const QueueManagementScreen({super.key});

  @override
  State<QueueManagementScreen> createState() => _QueueManagementScreenState();
}

class _QueueManagementScreenState extends State<QueueManagementScreen> {
  final List<Map<String, dynamic>> _liveQueue = [
    {
      'id': 'TKT-024',
      'name': 'Julian Reed',
      'service': 'Suit Repair',
      'waitTime': '10 mins ago',
    },
    {
      'id': 'TKT-025',
      'name': 'Ahmed El-Sayed',
      'service': 'Pants Hemming',
      'waitTime': '5 mins ago',
    },
    {
      'id': 'TKT-026',
      'name': 'Kareem Hassan',
      'service': 'Custom Shirt Measurements',
      'waitTime': '2 mins ago',
    },
  ];

  void _acceptTicket(Map<String, dynamic> ticket, AppLocalizations l10n) {
    setState(() {
      _liveQueue.removeWhere((t) => t['id'] == ticket['id']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.ticketAccepted(ticket['name'])),
        backgroundColor: AppColors.statusAvailable,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rejectTicket(Map<String, dynamic> ticket, AppLocalizations l10n) {
    setState(() {
      _liveQueue.removeWhere((t) => t['id'] == ticket['id']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.ticketDismissed(ticket['name'])),
        backgroundColor: AppColors.statusClosed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.surfaceGrey,
        appBar: AppBar(
          title: Text(l10n.queueManagement),
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: AppColors.textWhite,
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: AppColors.accentGold,
            indicatorWeight: 4,
            labelColor: AppColors.accentGold,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: l10n.liveQueue),
              Tab(text: l10n.activeOrders),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildLiveQueueTab(l10n), _buildActiveOrdersTab(l10n)],
        ),
      ),
    );
  }

  Widget _buildLiveQueueTab(AppLocalizations l10n) {
    if (_liveQueue.isEmpty) {
      return Center(
        child: Text(
          l10n.queueEmpty,
          style: const TextStyle(color: AppColors.textMedium, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _liveQueue.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: QueueTicketCard(
            ticket: _liveQueue[index],
            onAccept: () => _acceptTicket(_liveQueue[index], l10n),
            onReject: () => _rejectTicket(_liveQueue[index], l10n),
          ),
        );
      },
    );
  }

  Widget _buildActiveOrdersTab(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inventory_2_rounded,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.activeOrdersEmpty,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textMedium,
            ),
          ),
        ],
      ),
    );
  }
}
