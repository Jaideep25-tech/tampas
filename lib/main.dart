import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tampas/auth/auth.dart';
import 'package:tampas/pages/homepage.dart';
import 'package:tampas/pages/list.dart';
import 'package:tampas/pages/view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: View(),
    );
  }
}
