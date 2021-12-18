import 'package:flutter/material.dart';
import 'package:guidance/src/screens/first.dart';
import 'package:guidance/src/screens/second.dart';
import 'package:guidance/src/screens/third.dart';
import 'package:guidance/src/widgets/navbar_guide.dart';
import 'package:guidance/src/widgets/navbar_tourist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  bool isUserGuide =
      false; //false means user is a tourist, true means user is a guide

  List<Widget> guideNavList = const [FirstPage(), SecondPage(), ThirdPage()];
  List<Widget> touristNavList = const [FirstPage(), SecondPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: isUserGuide ? guideNavList : touristNavList,
      ),
      extendBody: true,
      bottomNavigationBar: isUserGuide
          ? NavbarGuide(pageController: pageController)
          : NavbarTourist(pageController: pageController),
    );
  }
}
