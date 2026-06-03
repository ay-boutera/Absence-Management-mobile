import 'package:abs/core/entities/teacher.dart';
import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String moduleId;
  final String day;
  final String timeStart;
  final String timeEnd;
  final String type;
  final String subject;
  final String? room;
  final String? group;
  final String year;
  final String? section;
  final String? speciality;
  final String semester;
  final List<Teacher> teachers;

  const SessionEntity({
    required this.id,
    required this.moduleId,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.type,
    required this.subject,
    this.room,
    this.group,
    required this.year,
    this.section,
    this.speciality,
    required this.semester,
    required this.teachers,
  });

  @override
  List<Object?> get props => [
    id,
    moduleId,
    day,
    timeStart,
    timeEnd,
    type,
    subject,
    room,
    group,
    year,
    section,
    speciality,
    semester,
    teachers,
  ];

  factory SessionEntity.fromJson(Map<String, dynamic> json) {
    // ignore: prefer_interpolation_to_compose_strings
    print("module id:" + json['module_id']);
    return SessionEntity(
      id: json['id'] ?? 0,
      moduleId: json['module_id'] ?? "",
      day: json['day'] ?? "",
      timeStart: json['time_start'] ?? "",
      timeEnd: json['time_end'] ?? "",
      type: json['type'] ?? "",
      subject: json['subject'] ?? "",
      room: json['room'] ?? "",
      group: json['group'] ?? "",
      year: json['year'] ?? "",
      section: json['section'] ?? "",
      speciality: json['speciality'] ?? "",
      semester: json['semester'] ?? "",
      teachers:
          (json['teachers'] as List<dynamic>?)
              ?.map(
                (teacherJson) =>
                    Teacher.fromJson(teacherJson as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}
