import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String day;
  final String timeStart;
  final String timeEnd;
  final String type;
  final String subject;
  final String room;
  final String? group;
  final String year;
  final String? section;
  final String? speciality;
  final String semester;
  final List<String> teachers;

  const SessionEntity({
    required this.id,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.type,
    required this.subject,
    required this.room,
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
    return SessionEntity(
      id: json['id'] as String,
      day: json['day'] as String,
      timeStart: json['time_start'] as String,
      timeEnd: json['time_end'] as String,
      type: json['type'] as String,
      subject: json['subject'] as String,
      room: json['room'] as String,
      group: json['group'] as String?,
      year: json['year'] as String,
      section: json['section'] as String?,
      speciality: json['speciality'] as String?,
      semester: json['semester'] as String,
      teachers: List<String>.from(json['teachers'] ?? []),
    );
  }
}
