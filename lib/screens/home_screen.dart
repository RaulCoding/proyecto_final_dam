import 'package:flutter/material.dart';

import 'package:proyecto_final_dam/components/components_barrell.dart';
import 'package:proyecto_final_dam/utils/firestore.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
    
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  //inicializamos firestore
  final FirestoreService firestoreService = FirestoreService();
  
  
  //controlador de texto
  final _controller = TextEditingController();
  
  //crear nueva tarea
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  
  //Guardar nueva tarea
  void saveNewTask(){
    setState(() {
      firestoreService.addTask(_controller.text);
      _controller.clear();
    });
      Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      )
    );
  }
}