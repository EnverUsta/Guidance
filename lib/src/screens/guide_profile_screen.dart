import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/models/enum/user_role.dart';
import 'package:guidance/src/models/guide_info.dart';
import 'package:guidance/src/models/user_model.dart';
import 'package:guidance/src/screens/chat_screen.dart';
import 'package:guidance/src/utils/services/chat_service.dart';
import 'package:guidance/src/utils/services/guide_info_service.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:guidance/src/utils/services/user_service.dart';
import 'package:sizer/sizer.dart';

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
  final GuideInfo? guideInfo;
  final DateTime? goalDate;
  final String? country;
  final String? city;
  const GuideProfileScreen(
      {Key? key, this.guideInfo, this.goalDate, this.country, this.city})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuideProfileScreenState();
  }
}

class _GuideProfileScreenState extends State<GuideProfileScreen> {
  var editToggle = false;
  GuideInfoService guideInfoService = GuideInfoService();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController introductionController = TextEditingController();
  UserRole userRole = UserRole.guide;
  bool isLoading = false;

  Future<void> _showMyDialog(GuideInfo guideInfo) async {
    TextEditingController hobbyCtrl = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Please enter a hobby'),
                TextField(
                  controller: hobbyCtrl,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                hobbyCtrl.text.trim();
                if (hobbyCtrl.text.isNotEmpty) {
                  setState(() {
                    guideInfo.hobbies.add(hobbyCtrl.text);
                  });
                  await guideInfoService.updateGuideInfo(guideInfo.userId,
                      guideInfo.introducion, guideInfo.hobbies);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.guideInfo != null) {
      userRole = UserRole.tourist;
    }
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: FutureBuilder<GuideInfo>(
        future: guideInfoService.getGuideInfo(userRole == UserRole.guide
            ? currentUserId
            : widget.guideInfo!.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final guide = snapshot.data!;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: ListView(
                children: <Widget>[
                  if (userRole == UserRole.tourist)
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 9.0.w,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  _buildProfileText(),
                  _buildProfileImageRow(guide),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  _buildIntroduction(
                    guide.introducion,
                    introductionController,
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildHobbiesText(guide),
                        _buildHobbyItems(guide.hobbies),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  if (userRole == UserRole.tourist)
                    FutureBuilder<bool>(
                        future: tripService.doesTripExist(guide.userId),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data! == true) {
                              return const SizedBox();
                            } else {
                              return SizedBox(
                                height: 7.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    TripService tripService = TripService();
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final tripId =
                                          await tripService.createTrip(
                                        guide.userId,
                                        widget.goalDate as DateTime,
                                        widget.country as String,
                                        widget.city as String,
                                      );
                                      await tripService
                                          .doesTripExist(guide.userId);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChatScreen(
                                            tripId: tripId,
                                            otherUserId: guide.userId,
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : const Text('Request'),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF7AAC5D),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        })
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileText() {
    return Padding(
      padding: EdgeInsets.only(top: 0.h, left: 1.h, right: 1.h, bottom: 1.h),
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

  Widget _buildProfileImageRow(GuideInfo guideInfo) {
    return Container(
      margin: EdgeInsets.only(top: 0.5.h, bottom: 2.h, right: 2.h),
      width: double.infinity,
      height: 18.h,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Profile image area
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              "assets/images/Saly-11.png",
              //"https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4",
              height: 25.w,
              width: 25.w,
              fit: BoxFit.cover,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          //End of Profile image area
          //Using container for responsive widget (sizer package usage)
          SizedBox(width: 2.w),
          //Profile name and desc area

          SizedBox(
            // color: Colors.red,
            width: 43.w,
            child: Text(
              guideInfo.name + " " + guideInfo.surname,
              style: GoogleFonts.nunito(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.raisinBlack),
            ),
          ),

          //End of Profile name end desc area
          //Using container for responsive widget (sizer package usage)
          // SizedBox(width: 2.w),
          //Edit button
          if (userRole == UserRole.guide)
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1.5,
                    blurRadius: 2,
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (editToggle) {
                        updateGuideInfo(
                          introductionController.text,
                          guideInfo.hobbies,
                        );
                      }
                      editToggle = !editToggle;
                    });
                  },
                  icon: (editToggle)
                      ? const Icon(Icons.save_outlined,
                          color: AppColors.raisinBlack)
                      : const Icon(Icons.drive_file_rename_outline_outlined,
                          color: AppColors
                              .raisinBlack), //edit toggle?show this: show that
                ),
              ),
            ),
          //End of Edit button
        ],
      ),
    );
  }

  Widget _buildIntroduction(
      String introduction, TextEditingController introductionController) {
    introductionController.text = introduction;
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
            if (editToggle)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: TextField(
                  controller: introductionController,
                ),
              )
            else
              Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(introductionController.text)),
          ],
        ),
      ),
    );
  }

  Widget _buildHobbyItems(List<String> hobbies) {
    return Container(
      margin: EdgeInsets.only(left: 1.5.h),
      height: 7.5.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        key: Key(hobbies.length.toString()),
        itemCount: hobbies.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Align(
              alignment: Alignment.center,
              child: itemCard(hobbies, index),
            ),
          );
        },
      ),
    );
  }

  Widget itemCard(List<String> hobbies, int index) {
    if (editToggle) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 1.w),
        color: AppColors.fireOpal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 6.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 1.8.w, right: 1.w),
                  child: Text(
                    hobbies[index],
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      hobbies.removeAt(index);
                      updateGuideInfo(introductionController.text, hobbies);
                      // guideInfo = getGuideInfo();
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
          height: 6.h,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 1.0.w, right: 1.0.w),
              child: Text(
                hobbies[index],
                maxLines: 1,
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

  Widget _buildHobbiesText(GuideInfo guideInfo) {
    return Container(
      margin: EdgeInsets.only(left: 2.h, top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hobbies",
            style: GoogleFonts.nunito(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.fireOpal,
            ),
          ),
          editToggle
              ? SizedBox(
                  height: 7.h,
                  child: Card(
                    child: IconButton(
                      onPressed: () async {
                        await _showMyDialog(guideInfo);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                )
              : Container(
                  height: 7.h,
                )
        ],
      ),
    );
  }
}
