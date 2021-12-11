import 'country.dart';

class City {
  final String id;
  final Country country;
  final String name;

  City({
    required this.id,
    required this.country,
    required this.name,
  });

  City.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        country = json['country'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'name': name,
      };
}
