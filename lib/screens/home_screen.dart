import 'package:cloud_firestore/cloud_firestore.dart';
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasksStream(),
        builder:(context, snapshot) {
          // Si tenemos datos, los tomamos
          if (snapshot.hasData){
            List taskList = snapshot.data!.docs;
            
            // Mostrar como linea
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                //Los toma individualmente
                DocumentSnapshot document = taskList[index];
                String docID = document.id;
                
                //toma la nota de cada doc
                Map<String, dynamic> data = 
                  document.data() as Map<String, dynamic>;
                String taskText = data['task'];
                //Lo muestra como una nota
                return ListTile(
                  title: Text(taskText),
                );
              } ,
            );
          // Si no hay datos
          } else {
            return const Text("Toca el icono '+' para añadir una nota");
          }
        }
      ),
    );
  }
}