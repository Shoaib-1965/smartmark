import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? elevation;
  final VoidCallback? onTap;
  final Border? border;
  final Gradient? gradient;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.border,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: gradient != null ? null : (backgroundColor ?? AppColors.cardBackground),
        gradient: gradient,
        borderRadius: borderRadius ?? AppSpacing.radiusLg,
        border: border,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, elevation ?? 2),
            blurRadius: (elevation ?? 2) * 2,
            color: Colors.black12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? AppSpacing.radiusLg,
        child: Padding(
          padding: padding ?? AppSpacing.paddingMd,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppSpacing.radiusLg,
        child: card,
      );
    }
    return card;
  }
}
