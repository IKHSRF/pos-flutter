import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _users = _firestore.collection('users');

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<String> signUp(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      print(user.uid);
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> signIn(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print(user.uid);
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<dynamic> getUserRole(String id) async {
    DocumentSnapshot snapshot = await _users.doc(id).get();
    return snapshot.data();
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
