import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  
  //consigue la colección de notas
  final CollectionReference notes =
    FirebaseFirestore.instance.collection('notes');
  
  
  //crea una nueva nota
  Future<void> addNote(String note){
    return notes.add({
      'note': note,
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