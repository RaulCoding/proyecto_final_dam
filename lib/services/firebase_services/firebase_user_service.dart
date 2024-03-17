import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_final_dam/services/firebase_services/firestore.dart';
import 'package:proyecto_final_dam/utils/utils.dart';

class FirebaseUserService extends FireStoreService {

 final String _collectionName = "users";

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<String?> registerUser(String email, String password, String name, String surname, String birthDate) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Store additional user data in Firestore
      await fireStore.collection(_collectionName).doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'surname': surname,
        'age': birthDate,
      });
      return null;
    } catch (e) {
      print(e);
      return Utils().extractErrorCode(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception("Error logging in: $e");
    }
  }
}