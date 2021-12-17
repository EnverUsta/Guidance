import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/trip.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('trips');
final FirebaseAuth _auth = FirebaseAuth.instance;

class TripService {
  Future<void> createTrip(Trip trip) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc();
      Map<String, dynamic> data = trip.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      print('Error in createTrip');
    }
  }

  Future<Trip> getTrip(String id) async {
    var collection = FirebaseFirestore.instance.collection('trips');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return Trip.fromJson(data!);
    } else {
      throw ("Not found Trip by this ID!");
    }
  }

  Future<List<Trip>> getTrips() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('Trips').get();

    List<Trip> trips = [];
    data.docs.forEach((element) {
      trips.add(Trip.fromJson(element.data()));
    });
    return trips;
  }
}
