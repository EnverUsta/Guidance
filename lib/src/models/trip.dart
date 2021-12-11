import 'country.dart';
import 'city.dart';
import 'user.dart';

class Trip {
  final String id;
  final User guide;
  final User tourist;
  final bool guideAcceptance;
  final bool touristAcceptance;
  //Datetime --sql lite doesn't support Date or like that type
  final String goalDate;
  final Country goalCountry;
  final City goalCity;
  final String ctime;
  final String utime;

  Trip({
    required this.id,
    required this.guide,
    required this.tourist,
    required this.guideAcceptance,
    required this.touristAcceptance,
    required this.goalCountry,
    required this.goalCity,
    required this.goalDate,
    required this.ctime,
    required this.utime,
  });
}
