import 'package:guidance/src/models/address.dart';

class UserModel {
  String id;
  String name;
  String surname;
  String email;
  String role;
  //Address address;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
    // required this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        role = json['role'];
  //address = json['address'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'role': role,
        //'address': address,
      };
}
