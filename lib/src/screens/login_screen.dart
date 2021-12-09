import 'package:flutter/material.dart';
import 'package:guidance/src/constants/user_role.dart';
import 'package:guidance/src/screens/signup_screen.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.userRole}) : super(key: key);
  final UserRole userRole;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temporary AppBar'),
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
                  height: 6.h,
                ),
                SizedBox(
                  width: 85.w,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Login',
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
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: <Widget>[
                    const Expanded(
                        child: Divider(
                      thickness: 3,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: const Text("or"),
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 3,
                    )),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  width: 85.w,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SignupScreen(userRole: widget.userRole),
                        ),
                      );
                    },
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFF25C54),
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