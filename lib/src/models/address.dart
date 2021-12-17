class Address {
  final String id;
  final String userId;
  final String country;
  final String city;

  Address({
    required this.id,
    required this.userId,
    required this.country,
    required this.city,
  });

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        country = json['country'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'country': country,
        'city': city,
      };
}
