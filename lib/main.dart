import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OTP Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? const LoginPage() : const HomePage(),
    );
  }
}
