import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCZGdOWUanV5PCFhYbjEmgjq1SR-ND0TXg",
            authDomain: "smartmark-zx5xa2.firebaseapp.com",
            projectId: "smartmark-zx5xa2",
            storageBucket: "smartmark-zx5xa2.firebasestorage.app",
            messagingSenderId: "774726662008",
            appId: "1:774726662008:web:5932026e56cd08a1bffa8d"));
  } else {
    await Firebase.initializeApp();
  }
}
