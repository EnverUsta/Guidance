import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guidance/src/screens/home_screen.dart';
import 'package:guidance/src/screens/role_selector_screen.dart';
import 'package:guidance/src/utils/services/auth_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
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
    UserService userService = UserService();
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
          title: 'Guidance',
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, // transparent status bar
              systemNavigationBarColor: Colors.black, // navigation bar color
              statusBarIconBrightness:
                  Brightness.dark, // status bar icons' color
              systemNavigationBarIconBrightness:
                  Brightness.dark, //navigation bar icons' color
            ),
            child: StreamBuilder<User?>(
              stream: _authservice.onAuthStateChanged,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final bool isSignedIn = snapshot.hasData;
                  if (isSignedIn) {
                    return const HomeScreen();
                  } else {
                    return const RoleSelectorScreen();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ));
    });
  }
}
