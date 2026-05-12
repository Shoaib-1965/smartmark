import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get employeesStream {
    return _db.collection('users').where('role', isEqualTo: 'employee').snapshots();
  }

  Stream<DocumentSnapshot> getUserStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> getAttendanceForDate(String dateStr) {
    return _db.collection('attendance').where('date', isEqualTo: dateStr).snapshots();
  }

  Stream<DocumentSnapshot> getTodayAttendance(String uid, String dateStr) {
    return _db.collection('attendance').doc('${uid}_$dateStr').snapshots();
  }

  Stream<QuerySnapshot> getMyAttendance(String uid) {
    return _db.collection('attendance')
        .where('employeeId', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getNotifications(String uid) {
    return _db.collection('notifications')
        .where('userId', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> updateEmployee(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  Future<void> markNotificationRead(String notifId) async {
    await _db.collection('notifications').doc(notifId).update({'isRead': true});
  }

  Future<List<Map<String, dynamic>>> calculatePayroll(String monthPrefix) async {
    final usersSnapshot = await _db.collection('users').where('role', isEqualTo: 'employee').get();
    
    // In a production app, use ranged queries. For simplicity, fetching all or ranged.
    final start = '$monthPrefix-01';
    final end = '$monthPrefix-31';
    
    final attendanceSnapshot = await _db.collection('attendance')
        .where('date', isGreaterThanOrEqualTo: start)
        .where('date', isLessThanOrEqualTo: end)
        .get();

    List<Map<String, dynamic>> payrollList = [];

    for (var userDoc in usersSnapshot.docs) {
      final userData = userDoc.data();
      final String uid = userData['uid'];
      final double hourlyRate = (userData['hourlyRate'] ?? 0.0).toDouble();
      
      double totalHours = 0.0;
      int daysPresent = 0;

      for (var attDoc in attendanceSnapshot.docs) {
        final attData = attDoc.data();
        if (attData['employeeId'] == uid) {
          totalHours += (attData['totalHours'] ?? 0.0).toDouble();
          if (attData['status'] == 'Present' || attData['status'] == 'Late') {
            daysPresent++;
          }
        }
      }

      payrollList.add({
        'uid': uid,
        'fullName': userData['fullName'],
        'department': userData['department'],
        'hourlyRate': hourlyRate,
        'totalHours': totalHours,
        'daysPresent': daysPresent,
        'grossSalary': totalHours * hourlyRate,
      });
    }

    return payrollList;
  }
}
