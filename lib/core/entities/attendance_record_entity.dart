import 'package:equatable/equatable.dart';

abstract class AttendanceRecordEntity extends Equatable {
  final String id;
  final String studentId;
  final String sessionId;
  final DateTime timestamp;
  final String status; // 'present', 'absent', 'late'
  final String method; // 'manual', 'qr', 'facial'

  const AttendanceRecordEntity({
    required this.id,
    required this.studentId,
    required this.sessionId,
    required this.timestamp,
    required this.status,
    required this.method,
  });

  @override
  List<Object?> get props => [id, studentId, sessionId, timestamp, status, method];
}
