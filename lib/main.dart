import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.yellow),
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        /// AUTH Routes
        RegisterScreen.route: (context) => RegisterScreen(),
        LoginScreen.route: (context) => const LoginScreen(),

        /// MyTODOList Routes
        TodoListScreen.route: (context) => const TodoListScreen(),
      },
    );
  }
}
