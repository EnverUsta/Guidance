import 'enum/user_role.dart';

class UserModel {
  String id;
  String name;
  String surname;
  String email;
  List<UserRole> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.roles,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        roles = json['roles'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'roles': roles,
      };
}
