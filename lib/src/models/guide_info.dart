class GuideInfo {
  String userId;
  String introducion;
  List<String> hobbies;

  GuideInfo({
    required this.userId,
    required this.introducion,
    required this.hobbies,
  });

  GuideInfo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        introducion = json['introducion'],
        hobbies = json['hobbies'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'introducion': introducion,
        'hobbies': hobbies,
      };
}
