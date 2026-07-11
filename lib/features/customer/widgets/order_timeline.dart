import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:tailor_shop/l10n/app_localizations.dart';

class OrderTimeline extends StatelessWidget {
  final int currentStep;
  final Color activeColor;

  const OrderTimeline({
    super.key,
    required this.currentStep,
    required this.activeColor,
  });

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
