import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_spacing.dart';
import '../models/dummy_data.dart';
import '../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedTab = 'All';
  final List<String> _tabs = ['All', 'Alerts', 'System'];

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = _selectedTab == 'All'
        ? DummyData.notifications
        : _selectedTab == 'Alerts'
            ? DummyData.notifications
                .where((n) =>
                    n.type == NotificationType.alert ||
                    n.type == NotificationType.success)
                .toList()
            : DummyData.notifications
                .where((n) =>
                    n.type == NotificationType.system ||
                    n.type == NotificationType.info)
                .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read',
                style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _tabs.map((tab) {
                final isSelected = _selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = tab),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? AppColors.accent
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: AppTypography.body.copyWith(
                            color: isSelected
                                ? AppColors.accent
                                : AppColors.textSecondary,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(filteredNotifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    final borderColor = _getBorderColor(notification.type);
    final iconData = _getIcon(notification.type);
    final iconColor = _getIconColor(notification.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.radiusMd,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.08))
        ],
        border: Border(left: BorderSide(color: borderColor, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(iconData, color: iconColor, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppTypography.subtitle.copyWith(
                      fontWeight: notification.isRead
                          ? FontWeight.w500
                          : FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(notification.message, style: AppTypography.caption),
                  const SizedBox(height: 4),
                  Text(notification.timeAgo,
                      style: AppTypography.small
                          .copyWith(color: AppColors.textLight)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('View',
                  style: TextStyle(color: AppColors.accent, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
        return AppColors.error;
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.info:
        return AppColors.accent;
      case NotificationType.system:
        return AppColors.textSecondary;
    }
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
        return Icons.warning_amber;
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.info:
        return Icons.info_outline;
      case NotificationType.system:
        return Icons.sync;
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
        return AppColors.error;
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.info:
        return AppColors.accent;
      case NotificationType.system:
        return AppColors.textSecondary;
    }
  }
}
