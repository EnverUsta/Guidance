/*
*   Author : @burakekinci
*   Guide profile page from the view of 'Guide'
*
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/models/guide_info.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/utils/services/guide_info_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:guidance/src/widgets/text_field_alert_dialog.dart';
import 'package:sizer/sizer.dart';

String name = "";
String surname = "";
String intro = "";
List<String> hobbies = []; // hobbies
//String newIntro = "";
//List<String> newHobbie = [];

Future<GuideInfo> getGuideInfo() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GuideInfoService giService = GuideInfoService();
  GuideInfo gInfo =
      await giService.getGuideInfo(_auth.currentUser!.uid.toString());
  return gInfo;
}

Future<UserModel> getUser() async {
  UserService uService = UserService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel user =
      await uService.getUserById(_auth.currentUser!.uid.toString());
  return user;
}

updateGuideInfo(String newIntro, List<String> newhobbies) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GuideInfoService guideService = GuideInfoService();
  await guideService.updateGuideInfo(
      _auth.currentUser!.uid.toString(), newIntro, newhobbies);
}

class GuideProfileScreen extends StatefulWidget {
  const GuideProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuideProfileScreenState();
  }
}

class _GuideProfileScreenState extends State<GuideProfileScreen> {
  var editToggle = false;

  Future<GuideInfo> guideInfo = getGuideInfo();
  Future<UserModel> user = getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 4.0.w),
        child: Column(
          children: <Widget>[
            _buildProfileText(),
            _buildProfileImageRow(),
            SizedBox(
              height: 2.5.h,
            ),
            // _buildIntroduction(),
            _buildHobbiesText(),
            _buildHobbyItems(),
            Visibility(visible: editToggle, child: _buildAddButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileText() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, left: 1.h, right: 1.h, bottom: 1.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Profile",
          style: GoogleFonts.nunito(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.raisinBlack),
        ),
      ),
    );
  }

  Widget _buildProfileImageRow() {
    user.then((UserModel value) {
      setState(() {
        name = value.name.toString();
        surname = value.surname.toString();
      });
    });
    return Container(
      margin: EdgeInsets.only(top: 0.5.h, bottom: 2.h),
      width: double.infinity,
      height: 18.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Profile image area
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.network(
              "https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4",
              height: 18.h,
              width: 17.h,
              fit: BoxFit.fill,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          //End of Profile image area
          //Using container for responsive widget (sizer package usage)
          SizedBox(width: 3.5.w),
          //Profile name and desc area
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name + " " + surname,
                  style: GoogleFonts.nunito(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.raisinBlack),
                ),
              ),
              Text(
                "Software Developer",
                style: GoogleFonts.nunito(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.raisinBlackLight),
              ),
            ],
          ),
          //End of Profile name end desc area
          //Using container for responsive widget (sizer package usage)
          SizedBox(width: 3.5.w),
          //Edit button
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
                child: IconButton(
              onPressed: () => setState(() {
                if (editToggle) {
                  updateGuideInfo(intro, hobbies);
                }
                editToggle = !editToggle;
              }),
              icon: const Icon(Icons.drive_file_rename_outline_outlined),
            )),
          ),
          //End of Edit button
        ],
      ),
    );
  }

  Future<Widget> _buildIntroduction() async {
    await guideInfo.then((GuideInfo value) {
      setState(() {
        intro = value.introducion.toString();
      });

      //print(value.introducion.toString());
    });
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: Column(
          children: <Widget>[
            //INTRODUCTION Title
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Introduction",
                style: GoogleFonts.nunito(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.fireOpal),
              ),
            ),
            //INTRODUCTION Content
            Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: Text(
                intro, //introduction
                style: GoogleFonts.lora(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHobbyItems() {
    guideInfo.then((GuideInfo value) {
      //print(value.introducion.toString());
      var hobbiesFromJson = value.hobbies;
      setState(() {
        hobbies = List<String>.from(hobbiesFromJson);
      });
    });

    return SizedBox(
      height: 4.5.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          key: Key(hobbies.length.toString()),
          itemCount: hobbies.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Align(
                alignment: Alignment.center,
                child: itemCard(index),
              ),
            );
          }),
    );
  }

  Widget itemCard(int index) {
    if (editToggle) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 1.w),
        color: AppColors.fireOpal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 4.5.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 1.8.w, right: 1.w),
                  width: 15.w,
                  child: TextFormField(
                    initialValue: hobbies[index],
                    onFieldSubmitted: (value) => {},
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5.w),
                        border: InputBorder.none),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      hobbies.removeAt(index);
                      updateGuideInfo(intro, hobbies);
                      guideInfo = getGuideInfo();
                    });
                  },
                  constraints: const BoxConstraints(maxWidth: 20),
                  icon: const Icon(Icons.highlight_off, color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 1.w),
        color: AppColors.fireOpal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 4.5.h,
          width: 20.w,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
              child: Text(
                hobbies[index],
                style: GoogleFonts.nunito(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildHobbiesText() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 4.w),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Hobbies",
            style: GoogleFonts.nunito(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.fireOpal),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 100.w,
      height: 8.h,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          primary: AppColors.budGreen,
        ),
        onPressed: () => setState(() {
          TextFieldAlertDialog(list: hobbies);
        }),
        child: Text(
          "Add",
          style: GoogleFonts.nunito(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
