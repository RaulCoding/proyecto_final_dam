import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              // Nombre de la app
              const Text(
                'TO DO LIST APP',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 24
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Inicie sesión para comenzar',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
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
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //No es miembro? registrarse
              const Row(
                children: [
                  Text('¿No tienes cuenta?'),
                  Text('Registrate ahora', style: TextStyle(color: Colors.blue),),
                  
                ],)
              
            ],),
        ),
      )
    );
  }
}