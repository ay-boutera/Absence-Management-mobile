import 'package:abs/config/constants/enums.dart';

abstract class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final UserType role;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.photoUrl,
    required this.role,
  });
}
