import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/guide_info_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserService {
  Future<void> createUser(UserModel user) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(user.id);
      Map<String, dynamic> data = user.toJson();
      await documentReferencer.set(data);

      if(user.role=="UserRole.guide"){
        GuideInfoService gis = GuideInfoService();
        gis.createGuideInfo(user.id);
      }
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

  Future<String> getUserId() async {
    return _auth.currentUser!.uid.toString();
  }

  Future<UserModel> getUserById(String id) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return UserModel.fromJson(data!);
    } else {
      throw ("Not found user by this ID!");
    }
  }

  Future<List<UserModel>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('users').get();

    List<UserModel> users = [];
    data.docs.forEach((element) {
      users.add(UserModel.fromJson(element.data()));
    });
    return users;
  }

  Future<List<UserModel>> getGuides(String city) async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('users').where('role', isEqualTo: 'UserRole.guide').where('city', isEqualTo: city).get();

    List<UserModel> users = [];
    data.docs.forEach((element) {
      users.add(UserModel.fromJson(element.data()));
    });
    return users;
  }
}