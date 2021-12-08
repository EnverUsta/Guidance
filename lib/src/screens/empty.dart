import 'package:flutter/material.dart';
import 'package:guidance/src/models/trip.dart';

class Empty extends StatelessWidget {
  Trip tripPlan;

  Empty(this.tripPlan);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(tripPlan.country),
        Text(tripPlan.city),
        Text(tripPlan.language),
        Text(tripPlan.tripDateTime.toString()),
      ],
    ));
  }
}
