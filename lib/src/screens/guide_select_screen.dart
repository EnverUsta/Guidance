import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/models/guide_info.dart';
import 'package:guidance/src/screens/chat_screen.dart';
import 'package:guidance/src/utils/services/chat_service.dart';
import 'package:guidance/src/utils/services/guide_info_service.dart';
import 'package:guidance/src/utils/services/trip_service.dart';
import 'package:sizer/sizer.dart';

class GuideSelectScreen extends StatefulWidget {
  final city;
  final country;
  final language;
  final tripDate;

  const GuideSelectScreen(
      {Key? key, this.country, this.city, this.language, this.tripDate})
      : super(key: key);

  @override
  _GuideSelectScreenState createState() => _GuideSelectScreenState();
}

class _GuideSelectScreenState extends State<GuideSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 13.h,
        leading: const BackButton(color: AppColors.raisinBlack),
        title: Text(
          'Select Your Guide',
          style: TextStyle(fontSize: 21.sp),
        ),
        backgroundColor: AppColors.mainBackgroundColor,
        foregroundColor: AppColors.raisinBlack,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.0.w),
        child: _buildGuideList(widget.tripDate, widget.country, widget.city),
      ),
    );
  }
}

Widget _buildGuideList(DateTime tripDate, String country, String city) {
  final guideInfoService = GuideInfoService();
  return FutureBuilder<Iterable<GuideInfo>>(
    future: guideInfoService.getGuideInfos(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return _buildGuideListCard(
                snapshot.data!.elementAt(index), tripDate, country, city);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget _buildGuideListCard(
    GuideInfo guideItem, DateTime tripDate, String country, String city) {
  return GestureDetector(
    onTap: () {
      debugPrint('Card tapped.');
      //await tripService.createTrip(guideItem.userId, tripDate,country, city);
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 0.2.h),
      child: Card(
        color: AppColors.lighterBackgroundColor,
        child: SizedBox(
          width: 80.w,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                height: 15.h,
                width: 15.h,
                child: Image.asset('assets/images/Saly-portrait.png',
                    fit: BoxFit.fitHeight),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guideItem.name + ' ' + guideItem.surname,
                    style: TextStyle(
                        color: AppColors.fireOpal,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 50.w,
                    child: Text(
                      guideItem.introducion.substring(
                        0,
                        (guideItem.introducion.length < 60
                            ? guideItem.introducion.length
                            : 60),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
