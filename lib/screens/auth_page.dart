import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/login_screen.dart';
import 'package:proyecto_final_dam/screens/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  
  //inicialmente muestra la loginScreen
  bool showLoginPage = true;
  
  void toggleScreen(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginScreen(showRegisterPage: toggleScreen);
    }else {
      return RegisterPage(showLoginPage: toggleScreen);
    }
  }
}