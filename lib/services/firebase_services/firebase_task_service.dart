import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_dam/services/firebase_services/firestore.dart';

class FirebaseTaskService extends FireStoreService {
 final String _collectionName = "tasks";

  Future<void> addTask(String title, String userId) async {
    try {
      // Get the current timestamp
      Timestamp currentTime = Timestamp.now();

      // Add the task to Firestore
      await fireStore.collection(_collectionName).add({
        'title': title,
        'userId': userId,
        'timestamp': currentTime,
      });
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  //
  Future<void> updateTask(String taskId, String title) async {
    try {
      await fireStore.collection(_collectionName).doc(taskId).update({
        'title': title,
      });
    } catch (e) {
      throw Exception("Error updating task: $e");
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await fireStore.collection(_collectionName).doc(taskId).delete();
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }

  Stream<QuerySnapshot> getTasksForUser(String userId) {
    try {
      return fireStore.collection(_collectionName).where('userId', isEqualTo: userId).snapshots();
    } catch (e) {
      throw Exception("Error getting tasks: $e");
    }
  }
}