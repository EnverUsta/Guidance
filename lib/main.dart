import 'package:flutter/material.dart';
import 'package:guidance/src/screens/trip_plan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Guidance',
      home: TripPlan(),
    );
  }
}