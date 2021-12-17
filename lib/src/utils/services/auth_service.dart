import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserService();

  Stream<User?> get onAuthStateChanged => _auth.userChanges();

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password,
      String name, String surname, UserRole role) async {
    try {
      UserCredential authResponse = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(authResponse.user!.uid);
      final userModel = UserModel(
        id: authResponse.user!.uid,
        email: email,
        name: name,
        surname: surname,
        role: role.toString(),
        country: '',
        city: '',
      );
      await userService.createUser(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //Sign in with email and password
  Future<bool?> signInWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel um = await userService.getUserInfo(email);
      print(um.id);
      print(um.email);
      print(um.name);
      print(um.role);

      return um.role == role.toString() ? true : false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
