import 'package:flutter/material.dart';
import 'package:proyecto_final_dam/components/dialog_box.dart';
import 'package:proyecto_final_dam/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
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