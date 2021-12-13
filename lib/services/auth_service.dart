import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_sports_interest/models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future updateEmail(
      {required String oldEmail,
      required String newEmail,
      required String password}) async {
    try {
      var user = await _firebaseAuth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((value) {
        value.user!.updateEmail(newEmail);
      });
    } catch (e) {
      return e;
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
