import 'dart:convert';

import 'enum/user_role.dart';

class UserModel {
  String id;
  String name;
  String surname;
  String email;
  String role;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'role': role,
      };
}
