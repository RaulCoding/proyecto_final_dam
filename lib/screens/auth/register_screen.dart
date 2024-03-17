import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_dam/screens/widgets/form_widgets/primary_text_field.dart';
import 'package:proyecto_final_dam/services/firebase_services/firebase_user_service.dart';
import 'package:proyecto_final_dam/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginScreen;
  const RegisterScreen({super.key, required this.showLoginScreen});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // FormKey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  //Controladores de texto
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseUserService _firestoreService = FirebaseUserService();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    
    super.dispose();
  }
  
  Future signUp() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        String? response = await _firestoreService.registerUser(_emailController.text,
            _passwordController.text,
            _nameController.text,
            _surnameController.text,
            _ageController.text
        );
        if (response == "firebase_auth/email-already-in-use") {
          // Abrir POPUP Error Email ya en uso
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Creamos el AlertDialog
              return AlertDialog(
                title: const Text('Error', style:
                TextStyle(
                  color: Colors.red, fontSize: 24,
                  fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,),
                content: const Text('El correo indicado ya se encuentra registrado.', style: TextStyle(
                   fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                  textAlign: TextAlign.center,),
                actions: [
                  // Botón para cerrar el popup
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar',
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (response != null) {
         // Abrir POPUP Error Inesperado
        }
      }
    } on Exception catch (e) {
      // Mostrar POPUP ERROR Inesperado
      print("Error Exception $e");
    }

  }
  
  bool passwordConfirmed(){
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
      } else {
      return false;
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  const Text('Registrese para continuar',style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 50),

                  //campo de texto email
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        PrimaryTextField(
                          controller: _nameController,
                          hintText: 'Nombre',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Este campo no puede estar vacío";
                            }
                            return null;
                          },
                        ),

                        PrimaryTextField(
                          controller: _surnameController,
                          hintText: 'Apellidos',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Este campo no puede estar vacío";
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          controller: _emailController,
                          hintText: 'Dirección de correo electrónico',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Este campo no puede estar vacío";
                            }
                            if (!Utils.isValidEmail(value ?? "")) {
                              return "Formato de correo incorrecto";
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          controller: _passwordController,
                          hintText: 'Contraseña',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Este campo no puede estar vacío";
                            }
                            else if (!passwordConfirmed()) {
                              return "Las contraseñas no coinciden";
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirmar contraseña',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Este campo no puede estar vacío";
                            } else if (!passwordConfirmed()) {
                              return "Las contraseñas no coinciden";

                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),


                  //Botón de iniciar sesión
                  GestureDetector(
                    onTap: signUp,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                          child: Text('Registrarse',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18,),
                          ),
                      ),
                    ),
                  ),


                  //No es miembro? registrarse
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Ya estoy registrado', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.showLoginScreen,
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}