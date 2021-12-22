import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserService();

  Stream<User?> get onAuthStateChanged => _auth.userChanges();

  //register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String surname,
      UserRole role,
      String country,
      String city) async {
    try {
      UserCredential authResponse = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userModel = UserModel(
        id: authResponse.user!.uid,
        email: email,
        name: name,
        surname: surname,
        role: role.toString(),
        country: country,
        city: city,
      );
      await userService.createUser(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      rethrow;
    }
  }

  //Sign in with email and password
  Future<bool?> signInWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel um = await userService.getUserInfo(email);

      return um.role == role.toString() ? true : false;
    } on FirebaseAuthException catch (_) {
      rethrow;
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
