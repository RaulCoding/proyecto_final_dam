import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_dam/config/models/task_model.dart';

class FirestoreService{
  
  //consigue la colección de notas
  final CollectionReference tasks =
    FirebaseFirestore.instance.collection('tasks');
  
  
  //crea una nueva nota
  Future<void> addTask(Task task){
    return tasks.add(task.toJson());
  }
  
  
  
  //Devuelve las notas de la DB  
  Stream<QuerySnapshot>getTasksStream(){
    final tasksStream =
      tasks.orderBy('timestamp', descending: true).snapshots();
      
      return tasksStream;
  }
  // Actualiza las notas dadas al doc id
  Future<void> updateTask (String docID, String newTask){
    return tasks.doc(docID).update({
      'task': newTask,
      'timestamp': Timestamp.now(),
    });
  }
  // Borra las notas dadas al doc id
  Future<void> deleteTask(String docID){
    return tasks.doc(docID).delete();
  }
    
}