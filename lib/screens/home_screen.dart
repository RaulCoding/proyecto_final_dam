import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_final_dam/utils/utils_barrell.dart';


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
  void openTaskBox({String? docID}) {
    showDialog(
      context: context, 
      builder: (context)=> AlertDialog(
        //text user input
        content: TextField(
          controller: _controller,
        ),
        actions: [
          ElevatedButton(
            onPressed: (){
              //añadir nueva tarea
              if (docID == null){
                firestoreService.addTask(_controller.text);
              }
              //Si ya tiene un docID
              else{
                firestoreService.updateTask(docID, _controller.text);
              }
              
              //Limpia el controlador de texto
              _controller.clear();
              
              //cierra la ventana
              Navigator.pop(context);
              
            }, 
            child: const Text('Añadir')
          )
        ],
      ) 
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks", textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: Colors.purple[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openTaskBox,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openTaskBox(docID: docID),
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteTask(docID), 
                        icon: const Icon(Icons.delete))
                    ],
                  ),
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