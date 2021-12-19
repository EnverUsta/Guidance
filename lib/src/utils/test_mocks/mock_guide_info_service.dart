import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:guidance/src/models/guide_info.dart';

final FirebaseFirestore _firestore = FakeFirebaseFirestore();
final CollectionReference _mainCollection = _firestore.collection('guideInfos');
final FirebaseAuth _auth = MockFirebaseAuth();

class MGuideInfoService {
  Future<void> createGuideInfo(
      String userId, String intro, List<String> hobbies) async {
    try {
      GuideInfo guideInfo =
          GuideInfo(userId: userId, introducion: intro, hobbies: hobbies);
      DocumentReference documentReferencer =
          _mainCollection.doc(guideInfo.userId);
      Map<String, dynamic> data = guideInfo.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GuideInfo> getGuideInfo(String id) async {
    var collection = _firestore.collection('guideInfos');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return GuideInfo.fromJson(data!);
    } else {
      throw ("Not found GuideInfo by this ID!");
    }
  }

  Future<List<GuideInfo>> getGuideInfos() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('guideInfos').get();

    List<GuideInfo> guideInfos = [];
    data.docs.forEach((element) {
      guideInfos.add(GuideInfo.fromJson(element.data()));
    });
    return guideInfos;
  }

  Future<void> deleteGuideInfo(String userId) async {
    try {
      var collection = _firestore.collection('guideInfos');
      await collection.doc(userId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGuideInfo(
      String userId, String newintro, List<String> newhobbies) async {
    try {
      FakeFirebaseFirestore()
          .collection('guideInfos')
          .doc(_auth.currentUser!.uid)
          .update({'introducion': newintro, 'hobbies': newhobbies});
    } catch (e) {
      rethrow;
    }
  }
}