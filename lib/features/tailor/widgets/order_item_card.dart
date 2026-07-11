import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class OrderItemCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final AppLocalizations l10n;
  final VoidCallback onMarkReady;

  const OrderItemCard({
    super.key,
    required this.order,
    required this.l10n,
    required this.onMarkReady,
  });

  @override
  Widget build(BuildContext context) {
    String displayStatus = '';
    if (order['statusKey'] == 'inProduction') {
      displayStatus = l10n.inProduction;
    } else if (order['statusKey'] == 'finalFitting') {
      displayStatus = l10n.finalFitting;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.surfaceGrey,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(
                Icons.checkroom_rounded,
                size: 48,
                color: AppColors.primaryNavy.withValues(alpha: 0.2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMedium,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.accentGold,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          displayStatus,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  order['service'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 16,
                      color: AppColors.textMedium,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      order['customer'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                AppButton(
                  onPressed: onMarkReady,
                  text: l10n.markReadyForPickup,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
