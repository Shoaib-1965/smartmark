import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum BadgeVariant { success, warning, error, info, neutral }

class AppBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final bool small;

  const AppBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.neutral,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 6 : 10,
        vertical: small ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: AppSpacing.radiusSm,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: small ? 10 : 12,
          fontWeight: FontWeight.w500,
          color: _textColor,
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (variant) {
      case BadgeVariant.success:
        return AppColors.success.withOpacity(0.15);
      case BadgeVariant.warning:
        return AppColors.warning.withOpacity(0.15);
      case BadgeVariant.error:
        return AppColors.error.withOpacity(0.15);
      case BadgeVariant.info:
        return AppColors.accent.withOpacity(0.15);
      case BadgeVariant.neutral:
        return AppColors.textSecondary.withOpacity(0.15);
    }
  }

  Color get _textColor {
    switch (variant) {
      case BadgeVariant.success:
        return AppColors.success;
      case BadgeVariant.warning:
        return const Color(0xFFb45309);
      case BadgeVariant.error:
        return AppColors.error;
      case BadgeVariant.info:
        return AppColors.accent;
      case BadgeVariant.neutral:
        return AppColors.textSecondary;
    }
  }
}
