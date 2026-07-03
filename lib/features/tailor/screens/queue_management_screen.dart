import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

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
          child: _QueueTicketCard(
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

class _QueueTicketCard extends StatelessWidget {
  final Map<String, dynamic> ticket;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _QueueTicketCard({
    required this.ticket,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerGrey.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.surfaceGrey,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.dividerGrey),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticket['id'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: AppColors.statusBusy,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ticket['waitTime'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.statusBusy,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  ticket['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ticket['service'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              InkWell(
                onTap: onAccept,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryNavy.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.primaryNavy,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: onReject,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.statusClosed.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.statusClosed,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
