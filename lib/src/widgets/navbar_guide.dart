//navbar for guide
import 'package:flutter/material.dart';

class NavbarGuide extends StatefulWidget {
  final PageController pageController;

  const NavbarGuide({Key? key, required this.pageController}) : super(key: key);

  @override
  _NavbarGuideState createState() => _NavbarGuideState();
}

class _NavbarGuideState extends State<NavbarGuide> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
