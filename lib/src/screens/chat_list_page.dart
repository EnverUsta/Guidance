import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guidance/src/models/myChatModel.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:sizer/sizer.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatModel> chatList = ChatModel.list;
  final tripService = TripService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
                  stream: tripService.getTrips(
                      _auth.currentUser!.uid, 'UserRole.tourist'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final tripDocs = snapshot.data.docs as List;
                    // chatDocs.sort((a, b) => a['ctime'].compareTo(b['ctime']));
                    return ListView.builder(
                      itemCount: tripDocs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              elevation: 0,
                              child: ListTile(
                                onTap: () {},
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
                                        tripDocs[index]['id'],
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
                                            color:
                                                chatList[index].isDeal == true
                                                    ? Colors.green
                                                    : Colors.red,
                                            shape: BoxShape.circle),
                                        child: (chatList[index].isDeal == true)
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 3.5.h,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 3.5.h,
                                              ))
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 45.w,
                                      child: Text(
                                        chatList[index].lastMessage,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      chatList[index].lastMessageTime,
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
