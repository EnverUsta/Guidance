import 'city.dart';

class Country {
  final String id;
  final String name;
  final List<City> cities;

  Country({
    required this.id,
    required this.name,
    required this.cities,
  });
}
