import 'package:guidance/src/models/enum/english_level.dart';

import 'enum/english_level.dart';

class GuideInfo {
  final String userId;
  final String school;
  final String introducion;
  final String hobbies;
  final EnglishLevel englishLevel;

  GuideInfo({
    required this.userId,
    required this.school,
    required this.introducion,
    required this.hobbies,
    required this.englishLevel,
  });

  GuideInfo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        school = json['school'],
        introducion = json['introducion'],
        hobbies = json['hobbies'],
        englishLevel = json['englishLevel'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'school': school,
        'introducion': introducion,
        'hobbies': hobbies,
        'englishLevel': englishLevel,
      };
}
