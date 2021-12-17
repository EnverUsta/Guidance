import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidance/src/models/chat.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('chats');
final FirebaseAuth _auth = FirebaseAuth.instance;

class ChatService {
  Future<void> createChat(Chat chat) async {
    try {
      DocumentReference documentReferencer = _mainCollection.doc(chat.id);
      Map<String, dynamic> data = chat.toJson();
      await documentReferencer.set(data);
    } catch (e) {
      print('Error in createChat');
    }
  }

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

  Future<List<Chat>> getChats() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('chats').get();

    List<Chat> chats = [];
    data.docs.forEach((element) {
      chats.add(Chat.fromJson(element.data()));
    });
    return chats;
  }
}
