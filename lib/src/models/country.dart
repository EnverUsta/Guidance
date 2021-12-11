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

  Country.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cities = json['cities'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cities': cities,
      };
}
