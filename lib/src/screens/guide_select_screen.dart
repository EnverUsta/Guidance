import 'package:flutter/material.dart';
import 'package:guidance/src/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class GuideSelectScreen extends StatefulWidget {
  const GuideSelectScreen({Key? key}) : super(key: key);

  @override
  _GuideSelectScreenState createState() => _GuideSelectScreenState();
}

class _GuideSelectScreenState extends State<GuideSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      appBar: AppBar(
        title: const Text('Select Your Guide'),
        backgroundColor: AppColors.mainBackgroundColor,
        foregroundColor: AppColors.raisinBlack,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.raisinBlack),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 4.0.w),
        child: Column(
          children: <Widget>[
            _buildGuideList(),
            _buildGuideList(),
            _buildGuideList(),
          ],
        ),
      ),
    );
  }
}

Widget _buildGuideList() {
  return const Text('Hello World');
}
