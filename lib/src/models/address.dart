import 'package:guidance/src/models/city.dart';
import 'package:guidance/src/models/country.dart';
import 'package:guidance/src/models/county.dart';

class Address {
  final int id;
  final int userId;
  final Country country;
  final City city;
  final County county;

  Address({
    required this.id,
    required this.userId,
    required this.country,
    required this.city,
    required this.county,
  });
}
