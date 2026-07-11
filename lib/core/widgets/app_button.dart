import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppButtonType { primary, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = type == AppButtonType.primary
        ? AppColors.primaryNavy
        : (type == AppButtonType.text ? Colors.transparent : AppColors.backgroundWhite);

    final Color foregroundColor = type == AppButtonType.primary
        ? AppColors.textWhite
        : (type == AppButtonType.text ? AppColors.textMedium : AppColors.primaryNavy);

    final BorderSide borderSide = type == AppButtonType.outlined
        ? const BorderSide(color: AppColors.primaryNavy, width: 2)
        : BorderSide.none;

    final ButtonStyle style = type == AppButtonType.text
        ? TextButton.styleFrom(
            foregroundColor: foregroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: type == AppButtonType.primary ? 2 : 0,
            shadowColor: AppColors.primaryNavy.withValues(alpha: 0.3),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: borderSide,
            ),
          );

    Widget buttonContent = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          );

    Widget button = type == AppButtonType.text
        ? TextButton(
            onPressed: isLoading ? null : onPressed,
            style: style,
            child: buttonContent,
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: style,
            child: buttonContent,
          );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
