import 'package:cloud_firestore/cloud_firestore.dart';

class HardwareSimulatorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> simulateAccess(String employeeId, String employeeName) async {
    try {
      await _db.collection('access_logs').add({
        'employeeId': employeeId,
        'employeeName': employeeName,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'granted',
        'processed': false,
      });
    } catch (e) {
      print("Simulation error: $e");
    }
  }
}
