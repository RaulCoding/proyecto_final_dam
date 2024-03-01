import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';

class Checking extends StatelessWidget {
  const Checking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return  const HomeScreen();
          } else {
            return  const AuthPage();
          }
        }
      ),
    );
  }
}