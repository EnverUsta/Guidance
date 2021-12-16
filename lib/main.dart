import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guidance/src/models/chat.dart';
import 'package:guidance/src/screens/chat_page.dart';
import 'package:guidance/src/screens/chat_list_page.dart';
import 'package:flutter/services.dart';

import 'package:guidance/src/screens/role_selector_screen.dart';
import 'package:guidance/src/screens/trip_plan.dart';
import 'package:guidance/src/utils/services/auth_service.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    AuthService _authservice = AuthService();
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
          title: 'Guidance',


          // home: RoleSelectorScreen(),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, // transparent status bar
              systemNavigationBarColor: Colors.black, // navigation bar color
              statusBarIconBrightness:
                  Brightness.dark, // status bar icons' color
              systemNavigationBarIconBrightness:
                  Brightness.dark, //navigation bar icons' color
            ),
            child: StreamBuilder(
              stream: _authservice.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final bool signedIn = snapshot.hasData;
                  return signedIn
                      ? const RoleSelectorScreen()
                      : const RoleSelectorScreen();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ));
    });
  }
}
