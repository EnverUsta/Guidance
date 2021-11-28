import 'package:flutter/material.dart';
import 'package:guidance/src/constants/user_role.dart';

class RoleSelector extends StatefulWidget {
  const RoleSelector({Key? key}) : super(key: key);

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  UserRole userRole = UserRole.guide;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: queryData.size.height / 10),
              child: const Text(
                'Guidance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(queryData.size.width / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roleCard(queryData, 'assets/images/Saly-1.png', 'Tourist'),
                  roleCard(queryData, 'assets/images/Saly-11.png', 'Guide')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: queryData.size.height / 20),
              width: queryData.size.width / 1.2,
              height: queryData.size.height / 15,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Go',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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

  GestureDetector roleCard(
      MediaQueryData queryData, String imageString, String roleName) {
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Image.asset(
              imageString,
              height: queryData.size.height / 4.5,
              width: queryData.size.height / 4.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                roleName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
