import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/screens/chat_list_screen.dart';
import 'package:guidance/src/screens/guide_profile_screen.dart';
import 'package:guidance/src/screens/trip_plan_screen.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:guidance/src/widgets/navbar_guide.dart';
import 'package:guidance/src/widgets/navbar_tourist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final userService = UserService();
  late bool isUserGuide;

  List<Widget> guideNavList = const [ChatListScreen(), GuideProfileScreen()];
  List<Widget> touristNavList = const [TripPlanScreen(), ChatListScreen()];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: userService.getUserById(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          isUserGuide = snapshot.data!.role == 'UserRole.guide' ? true : false;
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
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
