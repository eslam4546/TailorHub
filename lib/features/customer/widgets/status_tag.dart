import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  final String status;
  final Color color;
  final bool showDot;
  final bool hasBackground;

  const StatusTag({
    super.key,
    required this.status,
    required this.color,
    this.showDot = false,
    this.hasBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: hasBackground 
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
          : EdgeInsets.zero,
      decoration: hasBackground ? BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Icon(Icons.circle, size: hasBackground ? 7 : 8, color: color),
            const SizedBox(width: 5),
          ],
          Text(
            status,
            style: TextStyle(
              fontSize: hasBackground ? 11 : 12,
              fontWeight: hasBackground ? FontWeight.w600 : FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
