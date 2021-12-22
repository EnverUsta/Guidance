import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guidance/src/screens/chat_screen.dart';
import 'package:guidance/src/screens/role_selector_screen.dart';
import 'package:guidance/src/utils/services/auth_service.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:sizer/sizer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final tripService = TripService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService userService = UserService();
  String userRole = ""; // UserRole.guide or UserRole.tourist
  String otherUserName = ''; // guideNameor touristName
  String otherUserIdField = "";
  AuthService authService = AuthService();

  Future<void> _showMyDialog(AuthService authService) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You are about to log out are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  await authService.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const RoleSelectorScreen(),
                    ),
                  );
                }),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String>(
            future: userService.getUserRole(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                userRole = snapshot.data as String;
                if (userRole == "UserRole.guide") {
                  otherUserName = 'touristName';
                  otherUserIdField = 'touristId';
                } else {
                  otherUserName = 'guideName';
                  otherUserIdField = 'guideId';
                }
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Padding(
                          padding: EdgeInsets.all(2.w),
                          child: IconButton(
                            onPressed: () async {
                              await _showMyDialog(authService);
                            },
                            icon: const Icon(Icons.login_outlined),
                            iconSize: 4.h,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder<Object>(
                          stream: tripService.getTrips(
                              _auth.currentUser!.uid, userRole),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final tripDocs = snapshot.data.docs as List;
                              tripDocs.sort((a, b) => a['lastMessageTime']
                                  .compareTo(b['lastMessageTime']));
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
                                                builder: (context) =>
                                                    ChatScreen(
                                                        tripId: tripDocs[index]
                                                            ['id'],
                                                        otherUserId: tripDocs[
                                                                index]
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
                                                userRole != 'UserRole.guide'
                                                    ? "assets/images/Saly-11.png"
                                                    : "assets/images/Saly-1.png",
                                                fit: BoxFit.cover),
                                          ),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 55.w,
                                                child: Text(
                                                  tripDocs[index]
                                                      [otherUserName],
                                                  // chatList[index].contact.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                height: 4.h,
                                                width: 4.h,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: tripDocs[index][
                                                                'guideAcceptance'] ==
                                                            null
                                                        ? Colors.red
                                                        : tripDocs[index][
                                                                    'touristAcceptance'] ==
                                                                null
                                                            ? Colors.red
                                                            : tripDocs[index][
                                                                        'guideAcceptance'] &&
                                                                    tripDocs[
                                                                            index]
                                                                        [
                                                                        'touristAcceptance']
                                                                ? Colors.green
                                                                : Colors.red,
                                                    shape: BoxShape.circle),
                                                child: tripDocs[index][
                                                            'guideAcceptance'] ==
                                                        null
                                                    ? Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 3.5.h,
                                                      )
                                                    : tripDocs[index][
                                                                'touristAcceptance'] ==
                                                            null
                                                        ? Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 3.5.h,
                                                          )
                                                        : tripDocs[index][
                                                                    'guideAcceptance'] &&
                                                                tripDocs[index][
                                                                    'touristAcceptance']
                                                            ? Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size: 3.5.h,
                                                              )
                                                            : Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
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
                                                  tripDocs[index]
                                                      ['lastMessage'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    DateTime.fromMicrosecondsSinceEpoch(tripDocs[index]['lastMessageTime'].microsecondsSinceEpoch)
                                                                .day ==
                                                            DateTime.now().day
                                                        ? DateTime.fromMicrosecondsSinceEpoch(
                                                                    tripDocs[index]['lastMessageTime']
                                                                        .microsecondsSinceEpoch)
                                                                .hour
                                                                .toString() +
                                                            ":" +
                                                            DateTime.fromMicrosecondsSinceEpoch(
                                                                    tripDocs[index][
                                                                            'lastMessageTime']
                                                                        .microsecondsSinceEpoch)
                                                                .minute
                                                                .toString()
                                                        : DateTime.fromMicrosecondsSinceEpoch(
                                                                tripDocs[index]
                                                                        ['lastMessageTime']
                                                                    .microsecondsSinceEpoch)
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
                            }
                          }),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
