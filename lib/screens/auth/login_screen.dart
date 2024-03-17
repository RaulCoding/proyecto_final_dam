import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:proyecto_final_dam/screens/screens_barrell.dart';
import 'package:proyecto_final_dam/services/firebase_services/firebase_user_service.dart';
import 'package:proyecto_final_dam/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterScreen;
  const LoginScreen({super.key, required this.showRegisterScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  //key control formato email formulario
  final GlobalKey<FormState> _formKey = GlobalKey();
  
  //Controladores de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseUserService _firestoreService = FirebaseUserService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Future signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _firestoreService.login(_emailController.text.trim(), _passwordController.text.trim())
;
}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: TextFormField(
                              validator: (value) {
                                if(value?.isEmpty ?? true){
                                  return "Este campo no puede estar vacio";
                                } else if(!Utils.isValidEmail(value ?? "")) {
                                  return "El texto debe tener un formato de correo";
                                }
                                  return null;
                              },
                              controller: _emailController,
                              decoration: const InputDecoration(
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: TextFormField(
                              validator: (value) {
                                if(value?.isEmpty ?? true){
                                  return "Este campo no puede estar vacio";
                                } return null;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
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
                        child: GestureDetector(
                          onTap: signIn,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(12)  
                            ),
                            child: const Center(
                                child: Text('Iniciar Sesión',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,),
                                ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 10),
                
                //No es miembro? registrarse
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.showRegisterScreen,
                      child: const Text(
                        'Registrate ahora', 
                        style: TextStyle(
                          color: Colors.blue, 
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context){
                            return ForgotPasswordScreen();
                        }
                      )
                    );
                  },
                  child: const Text(
                    '¿No recuerda su contraseña?'
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}