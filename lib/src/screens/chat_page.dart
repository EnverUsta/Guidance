import 'package:flutter/material.dart';

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
          margin: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              upperBarBuilder(),
              const SizedBox(
                height: 12,
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
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.blue,
                child: Icon(Icons.volume_up,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.height * 0.10), //change with profile photo
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ahmet Huzeyfe Demir",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
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
                    ),
                  ),
                  const SizedBox(
                    width: 12,
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 0.1,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.solid)),
                      child: TextField(
                        //keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 5,
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: 'Write a message',
                            contentPadding: EdgeInsets.all(15),
                            border: InputBorder.none),
                        //onChanged: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        //print(messageController.text); =
                        _messageController.text =
                            _messageController.text.trim();
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
