//navbar for guide
import 'package:flutter/material.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/constants/custom_icons_icons.dart';

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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              spreadRadius: 10,
              blurRadius: 5,
              offset: const Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 15,
          backgroundColor: AppColors.mainBackgroundColor,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sort_rounded,
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.comment,
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30,
              ),
              label: "",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.35),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
