import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chat_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_application_1/models/contact_model.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const IconData airplane_ticket_outlined =
      IconData(0xee5e, fontFamily: 'MaterialIcons');
  static const IconData assignment_turned_in_rounded =
      IconData(0xf588, fontFamily: 'MaterialIcons');
  static const IconData dangerous =
      IconData(0xe1af, fontFamily: 'MaterialIcons');
  List<ChatModel> list = ChatModel.list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Chat List Page"),
        actions: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.filter))
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Conversations",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                              image: ExactAssetImage("default.jpg"),
                            ),
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list[index].contact.name),
                            Container(
                                child: (list[index].isDeal == true)
                                    ? Icon(assignment_turned_in_rounded)
                                    : Icon(dangerous))
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(list[index].lastMessage),
                            Text(
                              list[index].lastMessageTime,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(airplane_ticket_outlined), title: Text("")),
        ],
      ),
    );
  }
}
