import 'package:flutter/material.dart';
import 'package:guidance/src/constants/user_role.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.userRole}) : super(key: key);
  final UserRole userRole;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    final querySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temporary Appbar'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(querySize.height / 30),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                      onChanged: (value) {},
                      validator: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: querySize.height / 40,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Surname',
                      ),
                      onChanged: (value) {},
                      validator: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: querySize.height / 40,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Mail',
                      ),
                      onChanged: (value) {},
                      validator: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: querySize.height / 40,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                      onChanged: (value) {},
                      validator: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: querySize.height / 20,
                ),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: querySize.width / 10,
                        vertical: querySize.height / 120),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: const SizedBox(),
                      items: <String>['English']
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    child: Text(value),
                                    value: value,
                                  ))
                          .toList(),
                      onChanged: (newValue) {
                        dropdownValue = newValue.toString();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: querySize.height / 20,
                ),
                SizedBox(
                  width: querySize.width / 1.2,
                  height: querySize.height / 15,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF7AAC5D),
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
