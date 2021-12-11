import 'enum/user_role.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String birthDate;
  final String phoneNo;
  final List<UserRole> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.phoneNo,
    required this.roles,
  });
}
