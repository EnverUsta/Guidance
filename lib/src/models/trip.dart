class Trip {
  final String id;
  final String guideId;
  final String touristId;
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
    required this.guideId,
    required this.touristId,
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
        guideId = json['guideId'],
        touristId = json['touristId'],
        guideAcceptance = json['guideAcceptance'],
        touristAcceptance = json['touristAcceptance'],
        goalCountry = json['goalCountry'],
        goalCity = json['goalCity'],
        goalDate = json['goalDate'],
        ctime = json['ctime'],
        utime = json['utime'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'guide': guideId,
        'tourist': touristId,
        'guideAcceptance': guideAcceptance,
        'toursitAcceptance': touristAcceptance,
        'goalCountry': goalCountry,
        'goalCity': goalCity,
        'goalDate': goalDate,
        'ctime': ctime,
        'utime': utime,
      };
}
