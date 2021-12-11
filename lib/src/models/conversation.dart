import 'user.dart';

class Conversation {
  final int id;
  final User guide;
  final User tourist;
  final bool guideAcceptance;
  final bool touristAcceptance;
  //Datetime --sql lite doesn't support Date or like that type
  final String goalDate;
  final String ctime;
  final String utime;

  Conversation({
    required this.id,
    required this.guide,
    required this.tourist,
    required this.guideAcceptance,
    required this.touristAcceptance,
    required this.goalDate,
    required this.ctime,
    required this.utime,
  });
}
