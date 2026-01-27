import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final bool isLarge;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.isLarge = false,
    this.gradient,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        textColor ?? (gradient != null ? Colors.white : AppColors.textPrimary);

    return Container(
      padding: EdgeInsets.all(isLarge ? 20 : 16),
      decoration: BoxDecoration(
        color: gradient != null
            ? null
            : (backgroundColor ?? AppColors.cardBackground),
        gradient: gradient,
        borderRadius: AppSpacing.radiusLg,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTypography.caption.copyWith(
              color: color.withOpacity(gradient != null ? 0.9 : 0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: isLarge ? 36 : 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: AppTypography.small.copyWith(
                color: color.withOpacity(gradient != null ? 0.8 : 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
