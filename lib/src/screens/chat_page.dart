import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guidance/src/models/chat.dart';
import 'package:guidance/src/utils/services/chat_service.dart';
import 'package:guidance/src/widgets/message_field.dart';
import 'package:sizer/sizer.dart';

addMessage(String tripId, String message) async {
  ChatService cs = ChatService();
  await cs.createChat(tripId, message);
}

FirebaseAuth user = FirebaseAuth.instance;

Future<List<Chat>> getMessages(String tripId) async {
  ChatService cs = ChatService();
  List<Chat> chats = await cs.getChats("11111");
  return chats;
}

List<Chat> tempChats = [];
Stream<QuerySnapshot>? chatsSnapshot;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  //final String? chatRoomId;

  //ChatPage({this.chatRoomId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController _scrollController = ScrollController();

  void scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn);
      }
      
    });
  }

  //late Stream chats;

  /*List<Map<String, dynamic>> chats = [
    {"message": "start", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "other user", "sendByMe": false},
    {"message": "current user", "sendByMe": true},
    {"message": "last", "sendByMe": false},
  ];*/

  TextEditingController messageController = TextEditingController();

  //for test
  String uid = "current user";
  String otherUser = "other user";

  sendMessage() {
    addMessage("", messageController.text);

    /*Map<String, dynamic> messageMap = {
      "message": messageController.text,
      "sendByMe": true
    };

    setState(() {
      chats.add(messageMap);
    });
    */

    scrollDown();
  }

/*
  Widget chatMessageList() {
    chats.then((value) {
      setState(() {
        tempChats = value.toList();
      });
    });

    return ListView.builder(
        controller: _scrollController,
        itemCount: tempChats.length,
        itemBuilder: (context, index) {
          return MessageField(
            message: tempChats[index].message,
            sendByMe:
                tempChats[index].userId == user.currentUser!.uid.toString()
                    ? true
                    : false,
          );
        });
  }
*/
  Widget chatMessageListStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatsSnapshot,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageField(
                    message: snapshot.data!.docs[index].get('message'),
                    sendByMe: user.currentUser!.uid.toString() ==
                        snapshot.data!.docs[index].get('userId'), //to do
                  );
                })
            : Container();
      },
    );
  }

  int dealStatus = 0; // accep:1, decline:-1, nothing:0
  Color acceptButtonColor = Colors.green;
  Color declineButtonColor = Colors.red;
  late String message = "";

  @override
    void initState() {
      ChatService().getChatsSnapshot("11111").then((val) {
        // to do
        setState(() {
          chatsSnapshot = val;
          print("******************");
          print(chatsSnapshot!.toList());
        });
      });
      super.initState();
    }

  //Future<List<Chat>> chats = getMessages("11111");
  @override
  Widget build(BuildContext context) {
    

    Timer(
      Duration(seconds: 1),
      () =>scrollDown()
          //_scrollController.jumpTo(_scrollController.position.maxScrollExtent),
    );

    //var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
          title: Text("Plan Your Trip"),
        ),*/
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
      return SizedBox(
        width: 45.w,
        child: Text(
          "Ahmet Huzeyfe Demir",
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
        });
      }
    }

    void declineButton() {
      if (dealStatus == 0) {
        dealStatus = -1;
        setState(() {
          declineButtonColor = Colors.grey;
        });
      }
    }

    Widget dealStatusButtons() {
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
      child: Container(
        width: double.infinity,
        //color: Colors.lightBlueAccent,
        child: chatMessageListStream(),
      ),
    );
  }

  Widget textBoxBuilder() {
    Widget textBox() {
      return Expanded(
        child: Container(
          alignment: Alignment.bottomLeft,
          //width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 0.05.w, color: Colors.grey, style: BorderStyle.solid)),
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
      );
    }

    Widget sendButton() {
      return Container(
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
      );
    }

    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.1,
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
                  textBox(),
                  sendButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
