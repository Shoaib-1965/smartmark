import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../models/attendance_record.dart';
import 'app_avatar.dart';
import 'app_badge.dart';

class AttendanceRecordCard extends StatelessWidget {
  final AttendanceRecord record;
  final VoidCallback? onTap;

  const AttendanceRecordCard({
    super.key,
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
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
            child: Column(
              children: [
                Row(
                  children: [
                    AppAvatar(initials: record.initials, radius: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(record.employeeName, style: AppTypography.subtitle),
                          const SizedBox(height: 2),
                          Text(record.employeeId, style: AppTypography.caption),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildTimeRow(AppColors.success, record.checkIn ?? '---'),
                          const SizedBox(height: 4),
                          _buildTimeRow(AppColors.error, record.checkOut ?? '---'),
                          if (record.duration != null) ...[
                            const SizedBox(height: 4),
                            Text(record.duration!, style: AppTypography.small),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (record.nfcVerified)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: const AppBadge(text: 'NFC ✓', variant: BadgeVariant.info, small: true),
                      ),
                    if (record.faceVerified)
                      const AppBadge(text: 'Face ✓', variant: BadgeVariant.info, small: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeRow(Color dotColor, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(time, style: AppTypography.body),
      ],
    );
  }
}
