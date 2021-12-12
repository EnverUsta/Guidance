import 'package:flutter/material.dart';
import 'package:guidance/src/screens/role_selector_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return const MaterialApp(
          title: 'Guidance',
          home: RoleSelectorScreen(),
        );
      },
    );
  }
}
