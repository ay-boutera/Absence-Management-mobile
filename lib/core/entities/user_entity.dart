import 'package:abs/config/constants/enums.dart';

class UserEntity {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final UserRole role;
  final bool isActive;
  final String level;
  final String group;
  final String? phone;
  final String? googleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActivity;
  final String studentId;

  // Student-specific fields
  final String? program;
  final bool? canSubmitJustifications;
  final bool? canViewAttendance;
  final bool? canConfirmRattrapage;
  final bool? isEnrolled;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    required this.role,
    required this.isActive,
    required this.level,
    required this.group,
    required this.studentId,
    this.phone,
    this.googleId,
    this.createdAt,
    this.updatedAt,
    this.lastActivity,
    this.program,
    this.canSubmitJustifications,
    this.canViewAttendance,
    this.canConfirmRattrapage,
    this.isEnrolled,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: UserRole.fromString(json['role'] as String),
      isActive: json['is_active'] as bool,
      phone: json['phone'] as String,
      googleId: json['google_id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      lastActivity: json['last_activity'] != null
          ? DateTime.parse(json['last_activity'] as String)
          : null,
      studentId: json['student_id'] as String,
      program: json['program'] as String?,
      level: json['level'] as String,
      group: json['group'] as String,
      canSubmitJustifications: json['can_submit_justifications'] as bool?,
      canViewAttendance: json['can_view_attendance'] as bool?,
      canConfirmRattrapage: json['can_confirm_rattrapage'] as bool?,
      isEnrolled: json['is_enrolled'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar_url': avatarUrl,
      'role': role.name,
      'is_active': isActive,
      'phone': phone,
      'google_id': googleId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'last_activity': lastActivity?.toIso8601String(),
      'student_id': studentId,
      'program': program,
      'level': level,
      'group': group,
      'can_submit_justifications': canSubmitJustifications,
      'can_view_attendance': canViewAttendance,
      'can_confirm_rattrapage': canConfirmRattrapage,
      'is_enrolled': isEnrolled,
    };
  }
}
