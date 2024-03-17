import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  final _emailController = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.
        sendPasswordResetEmail(email: _emailController.text.trim()
      );
      showDialog(
        context: context, 
        builder: (context){
          return const AlertDialog(
            content: Text("Se ha enviado un mensaje a su correo electrónico, compruebe su bandeja."),
          );
        }
      );    
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text(
              e.message.toString()
            ),
          );
        }
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Introduce tu Email', 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Dirección de correo electrónico',
                  fillColor: Colors.grey[200],
                  filled: true
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          
          MaterialButton(
            onPressed: passwordReset,
            child: const Text('Reiniciar contraseña'),
            color: Colors.deepPurple[200],
          )
        ],
      ),
    );
  }
}