class Trip {
  String? id;
  final String guideId;
  String? touristId;
  bool? guideAcceptance;
  bool? touristAcceptance;
  final DateTime goalDate;
  final String goalCountry;
  final String goalCity;

  Trip({
    this.id,
    required this.guideId,
    this.touristId,
    this.guideAcceptance,
    this.touristAcceptance,
    required this.goalCountry,
    required this.goalCity,
    required this.goalDate,
  });

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        guideId = json['guideId'],
        touristId = json['touristId'],
        guideAcceptance = json['guideAcceptance'],
        touristAcceptance = json['touristAcceptance'],
        goalCountry = json['goalCountry'],
        goalCity = json['goalCity'],
        goalDate = json['goalDate'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'guideId': guideId,
        'touristId': touristId,
        'guideAcceptance': guideAcceptance,
        'touristAcceptance': touristAcceptance,
        'goalCountry': goalCountry,
        'goalCity': goalCity,
        'goalDate': goalDate,
      };
}
