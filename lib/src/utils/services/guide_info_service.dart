import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/guide_info.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('guideInfos');
final FirebaseAuth _auth = FirebaseAuth.instance;

class GuideInfoService {
  Future<void> createGuideInfo(String name, String surname, String userId,
      String intro, List<String> hobbies) async {
    try {
      GuideInfo guideInfo = GuideInfo(
        name: name,
        surname: surname,
        userId: userId,
        introducion: intro,
        hobbies: hobbies,
      );
      DocumentReference documentReferencer =
          _mainCollection.doc(guideInfo.userId);
      Map<String, dynamic> data = guideInfo.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<GuideInfo> getGuideInfo(String id) async {
    var collection = FirebaseFirestore.instance.collection('guideInfos');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return GuideInfo.fromJson(data!);
    } else {
      throw ("Not found GuideInfo by this ID!");
    }
  }

  Future<Iterable<GuideInfo>> getGuideInfos() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('guideInfos').get();

    return data.docs.map((doc) => GuideInfo.fromJson(doc.data()));
  }

  Future<void> deleteGuideInfo(String userId) async {
    try {
      var collection = FirebaseFirestore.instance.collection('guideInfos');
      await collection.doc(userId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGuideInfo(
      String userId, String newintro, List<String> newhobbies) async {
    try {
      FirebaseFirestore.instance
          .collection('guideInfos')
          .doc(_auth.currentUser!.uid)
          .update({'introducion': newintro, 'hobbies': newhobbies});
    } catch (e) {
      rethrow;
    }
  }
}
