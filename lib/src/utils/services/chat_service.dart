import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/chat.dart';
import 'package:guidance/src/utils/services/trip_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('chats');
final FirebaseAuth _auth = FirebaseAuth.instance;
final TripService tripService = TripService();

class ChatService {
  Future<void> createChat(String tripId, String message) async {
    try {
      Chat chat = Chat(
        tripId: tripId,
        userId: _auth.currentUser!.uid.toString(),
        message: message,
        ctime: DateTime.now(),
      );
      FirebaseFirestore.instance.collection("chats").add(chat.toJson());

      //Update Trip
      tripService.updateLastMessageofTrip(tripId, message, chat.ctime);
    } catch (e) {
      print('Error in createChat');
    }
  }

  // Stream getLastMessage(String tripId) {
  //   return _firestore.collection('chats').where('tripId', isEqualTo: tripId);
  // }

  Future<Chat> getChat(String id) async {
    var collection = FirebaseFirestore.instance.collection('chats');
    var docSnapshot = await collection.doc(id).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      return Chat.fromJson(data!);
    } else {
      throw ("Not found chat by this ID!");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String tripId) {
    return _firestore
        .collection('chats')
        .where('tripId', isEqualTo: tripId)
        .snapshots();
  }
}
