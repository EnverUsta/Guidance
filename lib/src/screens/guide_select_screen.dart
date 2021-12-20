import 'package:flutter/material.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/models/guide_info.dart';
import 'package:guidance/src/utils/services/guide_info_service.dart';
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
        child: _buildGuideList(),
      ),
    );
  }
}

Widget _buildGuideList() {
  final guideInfoService = GuideInfoService();
  return FutureBuilder<Iterable<GuideInfo>>(
    future: guideInfoService.getGuideInfos(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return _buildGuideListCard(snapshot.data!.elementAt(index));
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

Widget _buildGuideListCard(GuideInfo guideItem) {
  final guideInfoService = GuideInfoService();
  return GestureDetector(
    onTap: () {
      debugPrint('Card tapped.');
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
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(width: 50.w, child: Text(guideItem.introducion))
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
