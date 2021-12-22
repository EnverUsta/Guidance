import 'package:flutter/material.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/utils/helpers/validator.dart';
import 'package:guidance/src/utils/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.userRole}) : super(key: key);
  final UserRole userRole;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String name = "";
  String surname = "";
  String email = "";
  String password = "";
  String? country;
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temporary Appbar'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(3.h),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                            ),
                            onChanged: (value) {
                              name = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field shouldn\'t be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Surname',
                            ),
                            onChanged: (value) {
                              surname = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'this field shouldn\'t be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Mail',
                            ),
                            onChanged: (value) {
                              email = value.trim();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field shouldn\'t be empty';
                              } else if (Validator.validateEmail(value)) {
                                return 'Please provide a correct email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: TextFormField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field shouldn\'t be empty';
                              } else if (value.length < 6) {
                                return 'Password length should be longer than 6 characters';
                              } else if (value.length >= 20) {
                                return 'Password length should be less than 20 characters';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: DropdownButtonFormField<String>(
                            value: country,
                            validator: (value) {
                              if (value == null) {
                                return 'This field shouldn\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            hint: const Text(
                              "Country",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 3.5.h,
                            onChanged: (String? newValue) {
                              setState(() {
                                country = newValue!;
                              });
                            },
                            items: <String>['Turkey']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: DropdownButtonFormField<String>(
                            value: city,
                            validator: (value) {
                              if (value == null) {
                                return 'This field shouldn\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            hint: const Text(
                              "City",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 3.5.h,
                            onChanged: (String? newValue) {
                              setState(() {
                                city = newValue!;
                              });
                            },
                            items: <String>['Istanbul']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final auth = AuthService();
                              try {
                                await auth.registerWithEmailAndPassword(
                                    email,
                                    password,
                                    name,
                                    surname,
                                    widget.userRole,
                                    country!,
                                    city!);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: const Text('An error occured'),
                                    action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {},
                                        textColor: Colors.white),
                                  ),
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            }
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
                              const Color(0xFF7AAC5D),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
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
