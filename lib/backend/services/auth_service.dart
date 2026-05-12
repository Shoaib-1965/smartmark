import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print("Login error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.get('role');
      }
    } catch (e) {
      print("Error getting role: $e");
    }
    return null;
  }

  Future<bool> createEmployee({
    required String email,
    required String password,
    required String fullName,
    required String cnic,
    required String department,
    required double hourlyRate,
    String photoUrl = '',
  }) async {
    try {
      FirebaseApp app = await Firebase.initializeApp(
          name: 'SecondaryApp', options: Firebase.app().options);
      FirebaseAuth secondaryAuth = FirebaseAuth.instanceFor(app: app);
      
      UserCredential result = await secondaryAuth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      if (result.user != null) {
        await _db.collection('users').doc(result.user!.uid).set({
          'uid': result.user!.uid,
          'fullName': fullName,
          'email': email,
          'role': 'employee',
          'cnic': cnic,
          'department': department,
          'joinDate': FieldValue.serverTimestamp(),
          'hourlyRate': hourlyRate,
          'photoUrl': photoUrl,
        });
      }
      
      await app.delete();
      return true;
    } catch (e) {
      print("Error creating employee: $e");
      return false;
    }
  }
}
