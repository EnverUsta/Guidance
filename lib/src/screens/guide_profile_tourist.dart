/*
*   Author : @burakekinci
*   Guide profile page from the view of 'Tourist'
*
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class GuideProfileForTourist extends StatefulWidget {
  const GuideProfileForTourist({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuideProfileForTouristState();
  }
}

class _GuideProfileForTouristState extends State<GuideProfileForTourist> {
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
            _buildIntroduction(),
            _buildHobbiesText(),
            _buildHobbyItems(),
            _buildRequestButton(),
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
          SizedBox(width: 3.5.w),
          //Profile name and desc area
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Burak Ekinci",
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
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
    List<String> list = [
      "Swim",
      "Dance",
      "Books",
      "test",
      "aaaa",
      "bbbb",
    ];
    return SizedBox(
      height: 4.5.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 1.w),
                  color: AppColors.fireOpal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: 4.5.h,
                    width: 20.w,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
                        child: Text(
                          list[index],
                          style: GoogleFonts.nunito(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
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

  Widget _buildRequestButton() {
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
        onPressed: () {},
        child: Text(
          "Request",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
