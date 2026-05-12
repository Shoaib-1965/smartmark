import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceProcessorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void startListening() {
    _db
        .collection('access_logs')
        .where('processed', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          _processLog(change.doc);
        }
      }
    });
  }

  Future<void> _processLog(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) return;

    final String employeeId = data['employeeId'];
    final Timestamp timestamp = data['timestamp'];
    
    final dateStr = DateFormat('yyyy-MM-dd').format(timestamp.toDate());
    final attendanceId = '${employeeId}_$dateStr';

    final attendanceRef = _db.collection('attendance').doc(attendanceId);

    await _db.runTransaction((transaction) async {
      final attendanceSnapshot = await transaction.get(attendanceRef);

      if (!attendanceSnapshot.exists) {
        // First log of the day -> Check In
        final checkInTime = timestamp.toDate();
        final isLate = checkInTime.hour >= 10 && checkInTime.minute > 0;

        transaction.set(attendanceRef, {
          'employeeId': employeeId,
          'date': dateStr,
          'checkIn': timestamp,
          'checkOut': null,
          'totalHours': 0.0,
          'status': isLate ? 'Late' : 'Present',
        });
      } else {
        // Subsequent log -> Check Out update
        final currentData = attendanceSnapshot.data()!;
        final Timestamp checkInTs = currentData['checkIn'];
        
        final duration = timestamp.toDate().difference(checkInTs.toDate());
        final totalHours = duration.inMinutes / 60.0;

        transaction.update(attendanceRef, {
          'checkOut': timestamp,
          'totalHours': double.parse(totalHours.toStringAsFixed(2)),
        });
      }

      // Mark log as processed
      transaction.update(doc.reference, {'processed': true});
    });
  }
}
