import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/config/models/auth/user_data.dart';
import 'package:proyecto_final_dam/screens/screens_barrell.dart';
import 'package:proyecto_final_dam/screens/widgets/headers/main_screen_title.dart';
import 'package:proyecto_final_dam/screens/widgets/pop_ups/primary_pop_up.dart';
import 'package:proyecto_final_dam/services/todo_service/online/todo_service_online.dart';
import 'package:proyecto_final_dam/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  static const route = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //key control formato email formulario
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Controladores de texto
  final _emailController =
      TextEditingController(text: "raulhardplay3@gmail.com");
  final _passwordController = TextEditingController(text: "pokemon");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      UserData userData = UserData(
        email: _emailController.text,
        password: _passwordController.text,
      );
      bool loginSuccess = await ToDoServiceOnline().loginUser(userData);
      print("loginSuccess: $loginSuccess");
      if (loginSuccess) {
        Navigator.pushReplacementNamed(context, TodoListScreen.route);
      } else {
        PrimaryPopUp(
          title: 'Error',
          message: 'Usuario o contraseña incorrectos',
          // onClosePressed: () {},
        ).showPopup(context);
      }
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
                MainScreenTitle(),
                const SizedBox(height: 10),
                const Text(
                  'Inicie sesión para comenzar',
                  style: TextStyle(fontSize: 20),
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
                                if (value?.isEmpty ?? true) {
                                  return "Este campo no puede estar vacio";
                                } else if (!Utils.isValidEmail(value ?? "")) {
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
                                if (value?.isEmpty ?? true) {
                                  return "Este campo no puede estar vacio";
                                }
                                return null;
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
                                borderRadius: BorderRadius.circular(12)),
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
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                //No es miembro? registrarse
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RegisterScreen.route,
                          );
                        },
                        child: const Text('Registrate ahora',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
