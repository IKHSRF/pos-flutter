import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static String error;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Future<String> signUp(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user.uid;
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
      return user.uid;
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
