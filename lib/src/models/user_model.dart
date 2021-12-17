class UserModel {
  String id;
  String name;
  String surname;
  String email;
  String role;
  String country;
  String city;

  UserModel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.role,
      required this.country,
      required this.city});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        role = json['role'],
        country = json['country'],
        city = json['city'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'role': role,
        'country': country,
        'city': city
      };
}
