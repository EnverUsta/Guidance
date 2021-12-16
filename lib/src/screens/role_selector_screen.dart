import 'package:flutter/material.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/screens/login_screen.dart';
import 'package:sizer/sizer.dart';

class RoleSelectorScreen extends StatefulWidget {
  const RoleSelectorScreen({Key? key}) : super(key: key);

  @override
  State<RoleSelectorScreen> createState() => _RoleSelectorScreenState();
}

class _RoleSelectorScreenState extends State<RoleSelectorScreen> {
  UserRole userRole = UserRole.guide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Text(
                'Guidance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(
              width: 85.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roleCard('assets/images/Saly-1.png', 'Tourist'),
                  roleCard('assets/images/Saly-11.png', 'Guide')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 85.w,
              height: 7.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(userRole: userRole),
                    ),
                  );
                },
                child: Text(
                  'Go',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF7AAC5D),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector roleCard(String imageString, String roleName) {
    return GestureDetector(
      onTap: () {
        if (roleName == 'Tourist') {
          setState(() {
            userRole = UserRole.tourist;
          });
        } else {
          setState(() {
            userRole = UserRole.guide;
          });
        }
      },
      child: Card(
        color: userRole.toString() == 'UserRole.' + roleName.toLowerCase()
            ? const Color(0xFF7AAC5D)
            : Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.sp),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              imageString,
              height: 18.h,
              width: 18.h,
            ),
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Text(
                roleName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
