import 'package:equatable/equatable.dart';

abstract class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? photoUrl;
  final String role; // 'teacher' or 'student'

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.photoUrl,
    required this.role,
  });

  @override
  List<Object?> get props => [id, email, name, photoUrl, role];
}
