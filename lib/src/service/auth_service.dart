import 'package:assignment/src/utils/toast_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///AuthService - Auth Service is used for firebase login, logout and register
class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      ToastUtils.showFailed(message: e.toString());
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      ToastUtils.showFailed(message: e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
