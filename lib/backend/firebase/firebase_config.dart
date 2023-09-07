import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDk7Dp1uX7yOUSTdrjE_glwzaTXWgGwIQY",
            authDomain: "crowdstest-926f7.firebaseapp.com",
            projectId: "crowdstest-926f7",
            storageBucket: "crowdstest-926f7.appspot.com",
            messagingSenderId: "742267325997",
            appId: "1:742267325997:web:0f8fecd8aa457a75b9b2a4",
            measurementId: "G-75QD9KERPD"));
  } else {
    await Firebase.initializeApp();
  }
}
