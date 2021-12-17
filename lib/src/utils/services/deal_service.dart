import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/deal.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('deals');
final FirebaseAuth _auth = FirebaseAuth.instance;

class DealService {
  Future<void> createDeal(Deal deal) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(deal.id);
      Map<String, dynamic> data = deal.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      print('Error in createDeal');
    }
  }

  Future<Deal> getDeal(String id) async {
    var collection = FirebaseFirestore.instance.collection('deals');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return Deal.fromJson(data!);
    } else {
      throw ("Not found Deal by this ID!");
    }
  }

  Future<List<Deal>> getDeals() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('Deals').get();

    List<Deal> deals = [];
    data.docs.forEach((element) {
      deals.add(Deal.fromJson(element.data()));
    });
    return deals;
  }
}
