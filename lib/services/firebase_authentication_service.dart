// This class provides the authentication service by Firebase.
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // A function to get the current user's email.
  String? getUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  // A function to sign up a user with email and password.
  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // A function to sign in a user with email and password.
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  // A function to sign out the current user.
  bool signOutUser() {
    try {
      _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // A function to check if the current user is authenticated.
  bool checkAuthenticationStatus() {
    try {
      return _firebaseAuth.currentUser?.email != null;
    } catch (e) {
      return false;
    }
  }
}
