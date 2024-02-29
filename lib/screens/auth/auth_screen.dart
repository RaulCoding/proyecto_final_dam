import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  
  //inicialmente enseña la login screen
  bool showLoginScreen = true;
  
  void toggleScreens(){
    setState(() {
      showLoginScreen = !!showLoginScreen;
    });
  }
    
  @override
  Widget build(BuildContext context) {
    if (showLoginScreen){
      return LoginScreen(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens,);
    }
  }
}