class AttendanceRecord {
  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime date;
  final String? checkIn;
  final String? checkOut;
  final String? duration;
  final bool nfcVerified;
  final bool faceVerified;
  final String status;

  AttendanceRecord({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.duration,
    this.nfcVerified = false,
    this.faceVerified = false,
    required this.status,
  });

  String get initials {
    final parts = employeeName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return employeeName.substring(0, 2).toUpperCase();
  }
}
