import 'enum/user_role.dart';

class UserModel {
  String id;
  String name;
  String email;
  String birthDate;
  String phoneNo;
  List<UserRole> roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.phoneNo,
    required this.roles,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        birthDate = json['birthDate'],
        phoneNo = json['phoneNo'],
        roles = json['roles'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'birthDate': birthDate,
        'phoneNo': phoneNo,
        'roles': roles,
      };
}
