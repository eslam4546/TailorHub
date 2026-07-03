import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  List<Map<String, dynamic>> _getMockOrders(BuildContext context) {
    return [
      {
        'id': '#ORD-8821',
        'service': 'تفصيل بدلة • Formal Suit',
        'tailor': 'Ahmed El-Fashionista',
        'date': '15 Jul 2025 • 09:00 AM',
        'status': AppLocalizations.of(context)!.statusInProgress,
        'price': 1500,
      },
      {
        'id': '#ORD-8902',
        'service': 'تصليح قميص • Shirt Repair',
        'tailor': 'Fatma\'s Couture',
        'date': '18 Jul 2025 • 02:00 PM',
        'status': AppLocalizations.of(context)!.statusPending,
        'price': 80,
      },
      {
        'id': '#ORD-7104',
        'service': 'تفصيل جلابية • Custom Galabiya',
        'tailor': 'Omar The Tailor',
        'date': '02 Jun 2025 • 11:00 AM',
        'status': AppLocalizations.of(context)!.statusCompleted,
        'price': 350,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myOrders),
        backgroundColor: AppColors.primaryNavy,
        foregroundColor: AppColors.textWhite,
        centerTitle: true,
        elevation: 0,

        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _getMockOrders(context).length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final order = _getMockOrders(context)[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  Color _getStatusColor(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    if (status == l10n.statusPending) {
      return AppColors.accentGold;
    } else if (status == l10n.statusInProgress) {
      return AppColors.primaryNavy;
    } else if (status == l10n.statusCompleted) {
      return AppColors.statusAvailable;
    } else {
      return AppColors.textMedium;
    }
  }

  int _getStatusStepIndex(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context)!;
    if (status == l10n.statusPending) {
      return 0;
    } else if (status == l10n.statusInProgress) {
      return 1;
    } else if (status == l10n.statusCompleted) {
      return 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String status = order['status'];
    final Color statusColor = _getStatusColor(context, status);
    final int stepIndex = _getStatusStepIndex(context, status);

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryNavy,
                ),
              ),

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
            ],
          ),

          const SizedBox(height: 12),

          Text(
            order['service'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 16,
                color: AppColors.textMedium,
              ),
              const SizedBox(width: 6),
              Text(
                order['tailor'],
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: AppColors.textMedium,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    order['date'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
              Text(
                '${order['price']} EGP',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.dividerGrey, height: 1),
          ),

          _OrderTimeline(currentStep: stepIndex, activeColor: statusColor),
        ],
      ),
    );
  }
}

class _OrderTimeline extends StatelessWidget {
  final int currentStep;
  final Color activeColor;

  const _OrderTimeline({required this.currentStep, required this.activeColor});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<String> stepLabels = [
      l10n.statusPending,
      l10n.statusInProgress,
      l10n.statusCompleted,
    ];

    return Row(
      children: List.generate(stepLabels.length, (index) {
        final bool isCompleted = index <= currentStep;
        final bool isLast = index == stepLabels.length - 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted
                            ? activeColor
                            : AppColors.dividerGrey,
                        border: Border.all(
                          color: isCompleted
                              ? activeColor
                              : AppColors.dividerGrey,
                          width: 2,
                        ),
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              size: 10,
                              color: AppColors.textWhite,
                            )
                          : null,
                    ),
                    const SizedBox(height: 6),

                    Text(
                      stepLabels[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isCompleted
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isCompleted ? activeColor : AppColors.textMedium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,

                    color: index < currentStep
                        ? activeColor
                        : AppColors.dividerGrey,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
