import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_final_dam/config/models/task_model.dart';

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
  void openTaskBox({String? docID, String? title}) {
    showDialog(
      context: context, 
      builder: (context)=> AlertDialog(
        //text user input
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 18
              ),
            ),
            TextFormField(
              controller: _controller,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    //añadir nueva tarea
                    if (docID == null){
                      firestoreService.addTask(Task(task: _controller.text, userId: "userId"));
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
                  child: const Text('Aceptar')
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ElevatedButton(
                  onPressed:(){
                    _controller.clear();
                    Navigator.pop(context);
                  }, 
                  child: const Text("Cancelar")
                ),
              )
            ],
          )
        ],
      ) 
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();            
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTaskBox(title: "Añadir nueva tarea"),
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
                return Container(
                  margin: EdgeInsets.only(
                    left: 20, 
                    right: 20, 
                    bottom: 15, 
                    top: index == 0
                      ? 20 
                      : 0 
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(taskText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => openTaskBox(docID: docID, title: "Actualizar nombre tarea"),
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () => firestoreService.deleteTask(docID), 
                          icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              } ,
            );
          // Si no hay datos
          }else {
            return const Text("Toca el icono '+' para añadir una nota");
          }
        }
      ),
    );
  }
}