import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/user_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserService {
  Future<void> createUser(UserModel user) async {
    String userId = _auth.currentUser!.uid.toString();
    user.id = userId;
    DocumentReference documentReferencer = _mainCollection.doc();
    Map<String, dynamic> data = user.toJson();
    await documentReferencer.set(data);
  }
}
