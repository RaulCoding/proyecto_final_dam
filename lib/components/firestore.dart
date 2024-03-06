import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  
  //consigue la colección de notas
  final CollectionReference tasks =
    FirebaseFirestore.instance.collection('tasks');
  
  
  //crea una nueva nota
  Future<void> addTask(String task){
    return tasks.add({
      'task': task,
      'timestamp': Timestamp.now(),
    });
  }
  
  
  
  //Devuelve las notas de la DB  
  Stream<QuerySnapshot>gettasksStream(){
    final taskStream =
      tasks.orderBy('timestamp', descending: true).snapshots();
      
      return taskStream;
  }
  // Actualiza las notas dadas al doc id
  
  // Borra las notas dadas al doc id
  // Future<void> deleteNote(int index){
  // }
  
}