import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guidance/src/models/myChatModel.dart';
import 'package:guidance/src/models/trip.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/screens/chat_screen.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel> chatList = ChatModel.list;
  final tripService = TripService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserService();
  String userRole = ""; // UserRole.guide or UserRole.tourist
  String otherUserName = ''; // guideNameor touristName
  String otherUserIdField = "";
  @override
  Widget build(BuildContext context) {
    userService.getUserRole().then((value) {
      setState(() {
        userRole = value.toString();
      });
      if (userRole == "UserRole.guide") {
        otherUserName = 'touristName';
        otherUserIdField = 'touristId';
      } else {
        otherUserName = 'guideName';
        otherUserIdField = 'guideId';
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.h),
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Conversations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 4.h,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<Object>(
                  stream:
                      tripService.getTrips(_auth.currentUser!.uid, userRole),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final tripDocs = snapshot.data.docs as List;

                    tripDocs.sort((a, b) =>
                        a['lastMessageTime'].compareTo(b['lastMessageTime']));
                    return ListView.builder(
                      itemCount: tripDocs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          tripId: tripDocs[index]['id'],
                                          otherUserId: tripDocs[index]
                                              [otherUserIdField]),
                                    ),
                                  );
                                  //tripDocs[index]['id']  gönderilicek
                                },
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 15.h,
                                  ),
                                  child: Image.asset(
                                      "assets/images/Saly-11.png",
                                      fit: BoxFit.cover),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 55.w,
                                      child: Text(
                                        tripDocs[index][otherUserName],
                                        // chatList[index].contact.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 4.h,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: tripDocs[index]
                                                      ['guideAcceptance'] ==
                                                  null
                                              ? Colors.red
                                              : tripDocs[index][
                                                          'touristAcceptance'] ==
                                                      null
                                                  ? Colors.red
                                                  : tripDocs[index][
                                                              'guideAcceptance'] &&
                                                          tripDocs[index][
                                                              'touristAcceptance']
                                                      ? Colors.green
                                                      : Colors.red,
                                          shape: BoxShape.circle),
                                      child: tripDocs[index]
                                                  ['guideAcceptance'] ==
                                              null
                                          ? Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 3.5.h,
                                            )
                                          : tripDocs[index]
                                                      ['touristAcceptance'] ==
                                                  null
                                              ? Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 3.5.h,
                                                )
                                              : tripDocs[index]
                                                          ['guideAcceptance'] &&
                                                      tripDocs[index]
                                                          ['touristAcceptance']
                                                  ? Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 3.5.h,
                                                    )
                                                  : Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 3.5.h,
                                                    ),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 45.w,
                                      child: Text(
                                        tripDocs[index]['lastMessage'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                                          tripDocs[index]['lastMessageTime']
                                                              .microsecondsSinceEpoch)
                                                      .day ==
                                                  DateTime.now().day
                                              ? DateTime.fromMicrosecondsSinceEpoch(
                                                          tripDocs[index]['lastMessageTime']
                                                              .microsecondsSinceEpoch)
                                                      .hour
                                                      .toString() +
                                                  ":" +
                                                  DateTime.fromMicrosecondsSinceEpoch(
                                                          tripDocs[index]['lastMessageTime']
                                                              .microsecondsSinceEpoch)
                                                      .minute
                                                      .toString()
                                              : DateTime.fromMicrosecondsSinceEpoch(
                                                      tripDocs[index]['lastMessageTime'].microsecondsSinceEpoch)
                                                  .toString(),

                                          maxLines: 1,
                                          //overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
