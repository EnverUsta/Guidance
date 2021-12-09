import 'package:flutter/material.dart';
import 'package:guidance/src/constants/user_role.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.userRole}) : super(key: key);
  final UserRole userRole;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temporary Appbar'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
                  height: 3.h,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
                  height: 2.h,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
                  height: 3.h,
                ),
                Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
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
                  height: 3.h,
                ),
                Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.h,
                    ),
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
                  height: 3.h,
                ),
                SizedBox(
                  width: 85.w,
                  height: 6.h,
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
