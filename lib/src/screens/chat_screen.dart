import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/chat_service.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:guidance/src/widgets/message_field.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String tripId = "bVqvYXzQGXZJpDMFSFWp"; //to do
  String otherUserId = "vZ7ogWGtQwPgtPI7GY6rMoab1FD2"; // to do
  String firstName = "";
  String lastName = "";
  final ScrollController _scrollController = ScrollController();
  ChatService chatService = ChatService();
  UserService userService = UserService();
  TripService tripService = TripService();

  void scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  sendMessage() async {
    await chatService.createChat(tripId, messageController.text);
    scrollDown();
  }

  addMessage(String tripId, String message) async {
    await chatService.createChat(tripId, message);
  }

  TextEditingController messageController = TextEditingController();
  int dealStatus = 0; // accep:1, decline:-1, nothing:0
  Color acceptButtonColor = Colors.green;
  Color declineButtonColor = Colors.red;
  late String message = "";
  FirebaseAuth user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 400), () => scrollDown());

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(2.h),
            child: Column(
              children: [
                upperBarBuilder(),
                SizedBox(
                  height: 4.h,
                ),
                chatBodyBuilder(),
                textBoxBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperBarBuilder() {
    Widget backButton() {
      return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.black, size: 9.w),
      );
    }

    Widget avatarImage() {
      return SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Colors.blue,
            child: Icon(Icons.image,
                color: Colors.black, size: 10.h), //change with profile photo
          ),
        ),
      );
    }

    Widget userName() {
      Future<UserModel> userModel = userService.getUserById(otherUserId);
      userModel.then((value) {
        setState(() {
          firstName = value.name.toString();
          lastName = value.surname.toString();
        });
      });
      return SizedBox(
        width: 45.w,
        child: Text(
          firstName + " " + lastName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 5.w),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    void acceptButton() {
      if (dealStatus == 0) {
        dealStatus = 1;
        setState(() {
          declineButtonColor = Colors.grey;
          tripService.updateTripDealStatus(tripId, user.currentUser!.uid, true);
        });
      }
    }

    void declineButton() {
      if (dealStatus == 0) {
        dealStatus = -1;
        setState(() {
          acceptButtonColor = Colors.grey;
          tripService.updateTripDealStatus(tripId, user.currentUser!.uid, false);
        });
      }
    }

    Widget dealStatusButtons() {
      tripService.getTripStatusByTripId(tripId).then((value) {
        setState(() {
          if (value == null) {
            dealStatus = 0;
            acceptButtonColor = Colors.green;
            declineButtonColor = Colors.red;
          } else if (value) {
            dealStatus = 1;
            acceptButtonColor = Colors.green;
            declineButtonColor = Colors.grey;
          } else {
            dealStatus = -1;
            acceptButtonColor = Colors.grey;
            declineButtonColor = Colors.red;
          }
        });
      });

      return Row(
        children: [
          ElevatedButton(
            onPressed: acceptButton,
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.white,
              primary: acceptButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 5.h,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          ElevatedButton(
            onPressed: declineButton,
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.white,
              primary: declineButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 5.h,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        backButton(),
        SizedBox(
          width: 1.w,
        ),
        avatarImage(),
        SizedBox(
          width: 6.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userName(),
            SizedBox(
              height: 1.h,
            ),
            dealStatusButtons(),
          ],
        ),
      ],
    );
  }

  Widget chatBodyBuilder() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: StreamBuilder(
          stream: chatService.chatStream(tripId),
          builder: (BuildContext ctx, AsyncSnapshot chatSnapshot) {
            //just add this line
            if (chatSnapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final chatDocs = chatSnapshot.data.docs as List;
            chatDocs.sort((a, b) => a['ctime'].compareTo(b['ctime']));

            return Container(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MessageField(
                      message: chatDocs[index]['message'].toString(),
                      sendByMe:
                          user.currentUser!.uid == chatDocs[index]['userId']);
                },
                itemCount: chatDocs.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget textBoxBuilder() {
    return SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 1.h,
                top: 2.h,
              ),
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      //width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 0.05.w,
                              color: Colors.grey,
                              style: BorderStyle.solid)),
                      child: TextField(
                        //keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 5,
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: 'Write a message',
                            contentPadding: EdgeInsets.all(4.2.w),
                            border: InputBorder.none),
                        //onChanged: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        //print(messageController.text); =
                        messageController.text = messageController.text.trim();
                        if (messageController.text.isNotEmpty) {
                          sendMessage();
                          setState(() {
                            message = messageController.text;
                          });
                          messageController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
