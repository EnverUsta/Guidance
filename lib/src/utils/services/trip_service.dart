import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/models/trip.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/user_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('trips');
final FirebaseAuth _auth = FirebaseAuth.instance;
final UserService userService = UserService();

class TripService {
  Future<void> createTrip(String guideId, DateTime goalDate, String goalCountry,
      String goalCity) async {
    Trip trip = Trip(
      guideId: guideId,
      goalCountry: goalCountry,
      goalCity: goalCity,
      goalDate: goalDate,
      touristId: _auth.currentUser!.uid.toString(),
    );
    try {
      final result = await FirebaseFirestore.instance
          .collection("trips")
          .add(trip.toJson());
      trip.id = result.id;
      await FirebaseFirestore.instance
          .collection('trips')
          .doc(result.id)
          .update(trip.toJson());
    } catch (e) {
      print('Error in createTrip');
    }
  }

  // ! Ahmet gerek olmayacak dedi
  // Future<Trip> getTrip(String id) async {
  //   var collection = FirebaseFirestore.instance.collection('trips');
  //   var docSnapshot = await collection.doc(id).get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     return Trip.fromJson(data!);
  //   } else {
  //     throw ("Not found Trip by this ID!");
  //   }
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTrips(
      String userId, String role) {
    if (role == 'UserRole.tourist') {
      return _firestore
          .collection('trips')
          .where('touristId', isEqualTo: userId)
          .snapshots();
    } else {
      return _firestore
          .collection('trips')
          .where('guideId', isEqualTo: userId)
          .snapshots();
    }
  }
}
