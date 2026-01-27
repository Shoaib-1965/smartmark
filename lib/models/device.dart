class Device {
  final String id;
  final String name;
  final String type;
  final bool isOnline;
  final DateTime? lastSync;
  final String location;

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.isOnline,
    this.lastSync,
    required this.location,
  });

  String get lastSyncText {
    if (lastSync == null) return 'Never synced';
    final now = DateTime.now();
    final difference = now.difference(lastSync!);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
