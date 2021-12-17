import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/guide_info.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('guideInfos');
final FirebaseAuth _auth = FirebaseAuth.instance;

class GuideInfoService {
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
      print('Error in createGuideInfo');
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

  Future<List<GuideInfo>> getGuideInfos() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('GuideInfos').get();

    List<GuideInfo> guideInfos = [];
    data.docs.forEach((element) {
      guideInfos.add(GuideInfo.fromJson(element.data()));
    });
    return guideInfos;
  }

  Future<void> deleteGuideInfo(String userId) async {
    try {
      var collection = FirebaseFirestore.instance.collection('guideInfos');
      await collection.doc(userId).delete();
    } catch (e) {
      print('Error in createGuideInfo');
    }
  }

  Future<void> updateGuideInfo(
      String userId, String intro, String hobbie) async {
    try {
      GuideInfo guideInfo = await getGuideInfo(userId);
      deleteGuideInfo(userId);
      if (intro.isNotEmpty) {
        guideInfo.introducion = intro;
      }
      if (hobbie.isNotEmpty) {
        guideInfo.hobbies.add(hobbie);
      }
      createGuideInfo(userId, guideInfo.introducion, guideInfo.hobbies);
    } catch (e) {
      print('Error in createGuideInfo');
    }
  }
}
