import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/config/models/auth/user_data.dart';
import 'package:proyecto_final_dam/screens/auth/login_screen.dart';
import 'package:proyecto_final_dam/screens/to_do_list_screen.dart';
import 'package:proyecto_final_dam/screens/widgets/form_widgets/primary_text_field.dart';
import 'package:proyecto_final_dam/screens/widgets/headers/main_screen_title.dart';
import 'package:proyecto_final_dam/services/todo_service/online/todo_service_online.dart';
import 'package:proyecto_final_dam/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  static const route = "RegisterScreen";

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
      print("SignUIp");
      if (_formKey.currentState?.validate() ?? false) {
        UserData userData = UserData(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        bool registerSuccess =
            await ToDoServiceOnline().registerUser(userData, context);
        if (registerSuccess) {
          Navigator.of(context).pushNamed(TodoListScreen.route);
        }
      }
    } on Exception catch (e) {
      // Mostrar POPUP ERROR Inesperado
      print("Error Exception $e");
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff31363f),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MainScreenTitle(),

                    const SizedBox(height: 10),
                    const Text(
                      'Registrese para continuar',
                      style: TextStyle(fontSize: 20, color: Color(0xFFEEEEEE)),
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
                            obscureText: true,
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return "Este campo no puede estar vacío";
                              } else if (!passwordConfirmed()) {
                                return "Las contraseñas no coinciden";
                              }
                              return null;
                            },
                          ),
                          PrimaryTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirmar contraseña',
                            obscureText: true,
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
                            color: Color(0xff76abae),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //No es miembro? registrarse
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ya estoy registrado',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEEEEEE))),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.route,
                            );
                          },
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
