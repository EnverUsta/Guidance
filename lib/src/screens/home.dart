import 'package:flutter/material.dart';
import 'package:guidance/src/screens/first.dart';
import 'package:guidance/src/screens/second.dart';
import 'package:guidance/src/screens/third.dart';
import 'package:guidance/src/widgets/navbar_guide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
      bottomNavigationBar: NavbarGuide(pageController: pageController),
    );
  }
}
