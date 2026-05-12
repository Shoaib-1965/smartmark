import 'package:flutter/material.dart';

class ManagerNotificationsPage extends StatefulWidget {
  const ManagerNotificationsPage({Key? key}) : super(key: key);

  @override
  _ManagerNotificationsPageState createState() => _ManagerNotificationsPageState();
}

class _NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  bool isRead;

  _NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    this.isRead = false,
  });
}

class _ManagerNotificationsPageState extends State<ManagerNotificationsPage> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: '1',
      title: 'Late Arrival',
      subtitle: 'Usman Tariq arrived 45 mins late today.',
      time: '10 mins ago',
      icon: Icons.access_time_filled,
    ),
    _NotificationItem(
      id: '2',
      title: 'Employee Absent',
      subtitle: 'Omar Farooq has not checked in today.',
      time: '2 hours ago',
      icon: Icons.person_off,
    ),
    _NotificationItem(
      id: '3',
      title: 'System Update',
      subtitle: 'SmartMark app has been updated to v1.2.',
      time: '1 day ago',
      icon: Icons.info,
      isRead: true,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item.isRead = true;
      }
    });
  }

  Widget _buildNotificationCard(_NotificationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isRead = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: item.isRead ? Colors.grey.shade400 : const Color(0xFF1A73E8),
              width: 4,
            ),
            top: BorderSide(color: Colors.grey.shade200),
            right: BorderSide(color: Colors.grey.shade200),
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item.isRead ? Colors.grey.shade100 : const Color(0xFFE8F0FE),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: item.isRead ? Colors.grey : const Color(0xFF1A73E8),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
                            fontSize: 16,
                            color: item.isRead ? Colors.grey.shade700 : Colors.black,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      Text(
                        item.time,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: item.isRead ? Colors.grey : Colors.black87,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
        ),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
            ),
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_none, size: 64, color: Color(0xFF1A73E8)),
                  SizedBox(height: 16),
                  Text(
                    'No Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(_notifications[index]);
              },
            ),
    );
  }
}
