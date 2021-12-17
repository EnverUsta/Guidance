import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/address.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('address');
final FirebaseAuth _auth = FirebaseAuth.instance;

class AddressService {
  Future<void> createAddress(Address address) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(address.id);
      Map<String, dynamic> data = address.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      print('Error in createAddress');
    }
  }

  Future<Address> getAddressByUserId(String id) async {
    var collection = FirebaseFirestore.instance.collection('address');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return Address.fromJson(data!);
    } else {
      throw ("Not found address by this userID!");
    }
  }
}
