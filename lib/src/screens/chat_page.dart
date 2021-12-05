import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int dealStatus = 0;
  late String message = "";
  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
          title: Text("Plan Your Trip"),
        ),*/
      body: SafeArea(
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
            child: Icon(Icons.volume_up,
                color: Colors.black,
                size: MediaQuery.of(context).size.height *
                    0.10), //change with profile photo
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

    Widget dealStatusButtons() {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.white,
              primary: Colors.green,
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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.white,
              primary: Colors.red,
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
        color: Colors.lightBlueAccent,
        child: Text(message),
      ),
    );
  }

  Widget textBoxBuilder() {
    TextEditingController _messageController = TextEditingController();

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
            controller: _messageController,
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
            _messageController.text = _messageController.text.trim();
            if (_messageController.text.isNotEmpty) {
              setState(() {
                message = _messageController.text;
              });
              _messageController.clear();
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
