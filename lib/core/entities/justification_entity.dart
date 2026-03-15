import 'package:equatable/equatable.dart';

abstract class JustificationEntity extends Equatable {
  final String id;
  final String studentId;
  final String sessionId;
  final String reason;
  final String? attachmentUrl;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime submittedAt;

  const JustificationEntity({
    required this.id,
    required this.studentId,
    required this.sessionId,
    required this.reason,
    this.attachmentUrl,
    required this.status,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [id, studentId, sessionId, reason, attachmentUrl, status, submittedAt];
}
