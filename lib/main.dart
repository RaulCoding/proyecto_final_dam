import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/firebase_options.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: const Checking(),
=======
      home: const LoginScreen(),
>>>>>>> parent of 6df7b37 (Login & Logout Funcionando)
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
