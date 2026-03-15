import 'package:equatable/equatable.dart';

abstract class SessionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String teacherId;
  final String? qrCode;

  const SessionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.teacherId,
    this.qrCode,
  });

  @override
  List<Object?> get props => [id, title, description, startTime, endTime, teacherId, qrCode];
}
