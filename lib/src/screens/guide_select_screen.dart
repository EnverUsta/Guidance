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
        title: const Text('Select Your Guide'),
        backgroundColor: AppColors.mainBackgroundColor,
        foregroundColor: AppColors.raisinBlack,
        elevation: 0,
      ),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 4.0.w),
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
    child: Card(
      child: ListTile(
        leading: Image.asset('assets/images/Saly-11.png'),
        title: Text(guideItem.name),
        subtitle: Text(guideItem.shortInfo),
      ),
    ),
  );
}
