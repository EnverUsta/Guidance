import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:guidance/src/models/guide_list_item.dart';
import 'package:sizer/sizer.dart';

class GuideSelectScreen extends StatefulWidget {
  const GuideSelectScreen({Key? key}) : super(key: key);

  @override
  _GuideSelectScreenState createState() => _GuideSelectScreenState();
}

class _GuideSelectScreenState extends State<GuideSelectScreen> {
  final _guideInfoList = [
    GuideListItem(
        name: 'Enver Usta',
        shortInfo: 'faucibus nisl tincidunt eget nullam non nisi est sit amet'),
    GuideListItem(
        name: 'Ahmet Demir',
        shortInfo: 'faucibus nisl tincidunt eget nullam non nisi est sit amet'),
    GuideListItem(
        name: 'Burak Ekinci',
        shortInfo: 'faucibus nisl tincidunt eget nullam non nisi est sit amet'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      appBar: AppBar(
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
          child: _buildGuideList(_guideInfoList)),
    );
  }
}

Widget _buildGuideList(List<GuideListItem> guideInfoList) {
  return ListView.builder(
      itemCount: guideInfoList.length,
      itemBuilder: (context, index) {
        return _buildGuideListCard(guideInfoList[index]);
      });
}

Widget _buildGuideListCard(GuideListItem guideItem) {
  return GestureDetector(
    onTap: () {
      debugPrint('Card tapped.');
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 0.2.h),
      child: Card(
          color: AppColors.lighterBackgroundColor,
          child: Container(
              width: 80.w,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                    height: 15.h,
                    width: 15.h,
                    child: Image.asset('assets/images/Saly-portrait.png',
                        fit: BoxFit.fitHeight),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guideItem.name,
                          style: TextStyle(
                              color: AppColors.fireOpal,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(width: 50.w, child: Text(guideItem.shortInfo))
                      ],
                    ),
                  )
                ],
              ))),
    ),
  );
}
