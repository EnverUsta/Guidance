class GuideInfo {
  String name;
  String surname;
  String userId;
  String introducion;
  List<String> hobbies;

  GuideInfo({
    required this.name,
    required this.surname,
    required this.userId,
    required this.introducion,
    required this.hobbies,
  });

  GuideInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        surname = json['surname'],
        userId = json['userId'],
        introducion = json['introducion'],
        hobbies = List<String>.from(json['hobbies']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'userId': userId,
        'introducion': introducion,
        'hobbies': hobbies,
      };
}
