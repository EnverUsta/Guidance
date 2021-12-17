import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  //const Empty ({ Key? key }) : super(key: key);

  String goalCountry;
  String goalCity;
  String goalDate;
  Empty(this.goalCountry, this.goalCity, this.goalDate);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(goalCountry),
        Text(goalCity),
        Text(goalDate),
      ],
    );
  }
}
