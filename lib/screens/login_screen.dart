import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment,
                size: 100,
              ),
              const SizedBox(height: 25),
              // Nombre de la app
              Text('TO DO LIST APP',style: GoogleFonts.bebasNeue(fontSize: 52),
              ),
              const SizedBox(height: 10),
              const Text('Inicie sesión para comenzar',style: TextStyle(fontSize: 20),
              ),
              
              const SizedBox(height: 50),
              
              //campo de texto email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Dirección de correo electrónico',
                        hintStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              //campo de texto contraseña
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
                           
              //Botón de iniciar sesión
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(100)  
                  ),
                  child: const Center(
                      child: Text('Iniciar Sesión',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,),
                      ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              //No es miembro? registrarse
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes cuenta?', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Text('Registrate ahora', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}