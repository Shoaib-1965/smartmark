import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class TimelineItem extends StatelessWidget {
  final String date;
  final String checkIn;
  final String checkOut;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.borderLight,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: AppTypography.subtitle),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.login,
                          size: 14, color: AppColors.success),
                      const SizedBox(width: 4),
                      Text('In: $checkIn', style: AppTypography.caption),
                      const SizedBox(width: 16),
                      const Icon(Icons.logout,
                          size: 14, color: AppColors.error),
                      const SizedBox(width: 4),
                      Text('Out: $checkOut', style: AppTypography.caption),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
