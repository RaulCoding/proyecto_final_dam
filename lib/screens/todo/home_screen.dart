import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/components/components_barrell.dart';
import 'package:proyecto_final_dam/components/firestore.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  
  
  //controlador del texto
  final _controller = TextEditingController();
  
  //Lista de tareas
  List toDoList = [
    ["Hacer tuto", false],
    ["Hacer ejercicio", false]
  ];
  
  //Cuadradito pulsado
  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }
  
  //Guardar nueva tarea
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      firestoreService.addNote(_controller.text);
      _controller.clear();
    });
      Navigator.of(context).pop();
  }
  
  
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
  //Borrar tareas
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("Lista de tareas"),
        centerTitle: true,
        elevation: 0,
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
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: toDoList[index][0], 
            taskCompleted: toDoList[index][1], 
            onChanged: (value)=> checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }
      ),
    );
  }
}