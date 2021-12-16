import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/user_model.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserService {
  Future<void> createUser(UserModel user) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(user.id);
      Map<String, dynamic> data = user.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      print('Error in createUser');
    }
  }

  Future<UserModel> getUserInfo(String email) async {
    QuerySnapshot<Map<String, dynamic>> data = await _firestore
        .collection('users')
        .where("email", isEqualTo: email)
        .get();

    return UserModel.fromJson(data.docs.single.data());

    // commt by mehmet yazıcı ;)

    
  }
}
