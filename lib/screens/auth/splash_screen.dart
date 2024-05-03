import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/config/secure_storage/secure_storage.dart';
import 'package:proyecto_final_dam/screens/auth/login_screen.dart';
import 'package:proyecto_final_dam/screens/to_do_list_screen.dart';
import 'package:proyecto_final_dam/screens/widgets/headers/main_screen_title.dart';

class SplashScreen extends StatefulWidget {
  static const route = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToStartScreen();
  }

  void navigateToStartScreen() {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      if (await SecureStorageService().readAccessToken() != null &&
          await SecureStorageService().readRefreshToken() != null) {
        Navigator.pushReplacementNamed(context, TodoListScreen.route);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainScreenTitle(),
              SizedBox(height: 10),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
