import 'package:flutter/material.dart';
import 'package:guidance/src/screens/chat_page.dart';
import 'package:guidance/src/screens/role_selector_screen.dart';
import 'package:guidance/src/screens/trip_plan.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //tes
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          title: 'Guidance',
          home: RoleSelectorScreen(),
        );
      },
    );
  }
}
