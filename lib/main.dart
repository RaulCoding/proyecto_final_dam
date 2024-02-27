import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
