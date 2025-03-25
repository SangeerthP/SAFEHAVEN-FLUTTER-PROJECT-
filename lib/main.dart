import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDb-l4BAmS_liuCTooING9Rxg7vHPb8thI",
            authDomain: "miniii-3920c.firebaseapp.com",
            projectId: "miniii-3920c",
            storageBucket: "miniii-3920c.firebasestorage.app",
            messagingSenderId: "852758900982",
            appId: "1:852758900982:web:9ce0b0e09f2e68278cfcd7",
            measurementId: "G-EP74DVJPG5"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
