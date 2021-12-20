import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/test_mocks/mock_guide_info_service.dart';
import 'package:guidance/src/models/enum/user_role.dart';

final FirebaseFirestore _firestore = FakeFirebaseFirestore();
final CollectionReference _mainCollection = _firestore.collection('users');
final FirebaseAuth _auth = MockFirebaseAuth();

class MUserService {
  Future<void> createUser(UserModel user) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(user.id);
      Map<String, dynamic> data = user.toJson();
      await documentReferencer.set(data);

      if (user.role == "UserRole.guide") {
        MGuideInfoService gis = MGuideInfoService();
        List<String> hobbies = [];
        gis.createGuideInfo(user.name, user.surname, user.id, '', hobbies);
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

  Future<UserModel> getUserById(String? id) async {
    var collection = FakeFirebaseFirestore().collection('users');
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
    QuerySnapshot<Map<String, dynamic>> data = await _firestore
        .collection('users')
        .where('role', isEqualTo: "Guide")
        .where('city', isEqualTo: city)
        .get();

    List<UserModel> users = [];
    data.docs.forEach((element) {
      users.add(UserModel.fromJson(element.data()));
    });
    return users;
  }

  Future<String> getUserRole() async {
    var collection = FakeFirebaseFirestore().collection('users');
    var docSnapshot = await collection.doc(_auth.currentUser!.uid).get();
    try {
      Map<String, dynamic>? data = docSnapshot.data();

      // You can then retrieve the value from the Map like this:
      var value = data?['role'];
      return value;
    } catch (e) {
      rethrow;
    }
  }
}
