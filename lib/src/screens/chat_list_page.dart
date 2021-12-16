import 'package:flutter/material.dart';
import 'package:guidance/src/models/myChatModel.dart';
import 'package:sizer/sizer.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatModel> list = ChatModel.list;
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
              child: ListView.builder(
                itemCount: list.length,
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
                            child: Image.asset("assets/images/Saly-11.png",
                                fit: BoxFit.cover),
                          ),
                          /*Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: ExactAssetImage("Saly-1.png"),  
                              ),
                            ),
                          ),*/
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 55.w,
                                child: Text(
                                  list[index].contact.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                  height: 4.h,
                                  width: 4.h,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: list[index].isDeal == true
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle),
                                  child: (list[index].isDeal == true)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 45.w,
                                child: Text(
                                  list[index].lastMessage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
      ),
    );
  }
}
