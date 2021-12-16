import 'package:flutter/material.dart';

class TextFieldAlertDialog extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  TextFieldAlertDialog({Key? key, required this.list}) : super(key: key);

  final List<String> list;

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add new hobby'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(hintText: "Enter your hobby"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  list.add(_textFieldController.text);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _displayDialog(context);
  }
}
