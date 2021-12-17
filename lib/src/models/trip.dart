import 'user_model.dart';

class Trip {
  final String id;
  final UserModel guide;
  final UserModel tourist;
  final bool guideAcceptance;
  final bool touristAcceptance;
  //Datetime --sql lite doesn't support Date or like that type
  final String goalDate;
  final String goalCountry;
  final String goalCity;
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

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        guide = json['guide'],
        tourist = json['tourist'],
        guideAcceptance = json['guideAcceptance'],
        touristAcceptance = json['touristAcceptance'],
        goalCountry = json['goalCountry'],
        goalCity = json['goalCity'],
        goalDate = json['goalDate'],
        ctime = json['ctime'],
        utime = json['utime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'guide': guide,
        'tourist': tourist,
        'guideAcceptance': guideAcceptance,
        'toursitAcceptance': touristAcceptance,
        'goalCountry': goalCountry,
        'goalCity': goalCity,
        'goalDate': goalDate,
        'ctime': ctime,
        'utime': utime,
      };
}
