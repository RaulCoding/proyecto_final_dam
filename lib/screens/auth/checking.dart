
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:proyecto_final_dam/screens/screens_barrell.dart';
import 'package:proyecto_final_dam/services/firebase_services/firebase_user_service.dart';

class Checking extends StatelessWidget {
  const Checking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?> (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData && FirebaseUserService().getCurrentUser()?.uid != null){
            return  const HomeScreen();
          } else {
            return  const AuthPage();
          }
        }
      ),
    );
  }
}