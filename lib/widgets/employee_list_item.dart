import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../models/employee.dart';
import 'app_avatar.dart';
import 'app_badge.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final VoidCallback? onTap;

  const EmployeeListItem({
    super.key,
    required this.employee,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppSpacing.radiusMd,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 3,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSpacing.radiusMd,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                AppAvatar(initials: employee.initials, radius: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: AppTypography.subtitle,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${employee.id} • ${employee.department}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppBadge(
                      text: employee.status,
                      variant: _getStatusVariant(employee.status),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.checkInTime ?? '---',
                      style: AppTypography.small,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BadgeVariant _getStatusVariant(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return BadgeVariant.success;
      case 'late':
        return BadgeVariant.warning;
      case 'absent':
        return BadgeVariant.error;
      default:
        return BadgeVariant.neutral;
    }
  }
}
