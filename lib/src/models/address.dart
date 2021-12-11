import 'city.dart';
import 'country.dart';

class Address {
  final String id;
  final String userId;
  final Country country;
  final City city;

  Address({
    required this.id,
    required this.userId,
    required this.country,
    required this.city,
  });
}
