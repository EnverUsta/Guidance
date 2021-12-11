import 'package:guidance/src/models/enum/english_level.dart';

import 'enum/english_level.dart';

class Guide_Info {
  final int userId;
  final String school;
  final String introducion;
  final String hobbies;
  final EnglishLevel englishLevel;

  Guide_Info({
    required this.userId,
    required this.school,
    required this.introducion,
    required this.hobbies,
    required this.englishLevel,
  });
}
