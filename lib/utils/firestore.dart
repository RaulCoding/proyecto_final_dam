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
  // Stream<QuerySnapshot>getNotesStream(){
    // final noteStream =
      // notes.orderBy('timestamp', descending: true).snapshots();
      // 
      // return notesStream;
  // }
  // Actualiza las notas dadas al doc id
  
  // Borra las notas dadas al doc id
  
  
}