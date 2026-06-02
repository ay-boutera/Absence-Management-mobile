import 'package:abs/config/constants/enums.dart';
import 'package:flutter/material.dart';

class AbsenceEntity {
  final String absenceId;
  final String sessionId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String moduleName;
  final String teacherName;
  final bool isAbsent;
  final AbsenceStatus justificationStatus;
  final String sessionGroup;
  final bool isOwnGroup;
  final bool isCrossSession;

  AbsenceEntity({
    required this.absenceId,
    required this.sessionId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.moduleName,
    required this.teacherName,
    required this.isAbsent,
    required this.sessionGroup,
    required this.isOwnGroup,
    required this.isCrossSession,
    AbsenceStatus? justificationStatus,
  }) : justificationStatus = justificationStatus ?? AbsenceStatus.unjustified;

  Color getStatusColor(ThemeData theme) {
    switch (justificationStatus) {
      case AbsenceStatus.rejected:
        return theme.colorScheme.error;
      case AbsenceStatus.pending:
        return Colors.amber[700]!;
      case AbsenceStatus.justified:
        return Colors.green[700]!;
      case AbsenceStatus.unjustified:
        return theme.colorScheme.onSurface;
    }
  }

  String get statusText {
    switch (justificationStatus) {
      case AbsenceStatus.unjustified:
        return 'Unjustified';
      case AbsenceStatus.rejected:
        return 'Rejected';
      case AbsenceStatus.pending:
        return 'Pending';
      case AbsenceStatus.justified:
        return 'Justified';
    }
  }

  factory AbsenceEntity.fromJson(Map<String, dynamic> json) {
    return AbsenceEntity(
      absenceId: json['absence_id'] as String,
      sessionId: json['session_id'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      moduleName: json['module_name'] as String,
      teacherName: json['teacher_name'] as String,
      isAbsent: json['is_absent'] as bool,
      sessionGroup: json['session_group'] as String,
      isOwnGroup: json['is_own_group'] as bool,
      isCrossSession: json['is_cross_session'] as bool,
      justificationStatus: _parseStatus(
        json['justification_status'] as String?,
      ),
    );
  }

  AbsenceEntity copyWith({
    String? absenceId,
    String? sessionId,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? moduleName,
    String? teacherName,
    bool? isAbsent,
    AbsenceStatus? justificationStatus,
    String? sessionGroup,
    bool? isOwnGroup,
    bool? isCrossSession,
  }) {
    return AbsenceEntity(
      absenceId: absenceId ?? this.absenceId,
      sessionId: sessionId ?? this.sessionId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      moduleName: moduleName ?? this.moduleName,
      teacherName: teacherName ?? this.teacherName,
      isAbsent: isAbsent ?? this.isAbsent,
      justificationStatus: justificationStatus ?? this.justificationStatus,
      sessionGroup: sessionGroup ?? this.sessionGroup,
      isOwnGroup: isOwnGroup ?? this.isOwnGroup,
      isCrossSession: isCrossSession ?? this.isCrossSession,
    );
  }

  // Helper helper method to map incoming strings securely to your enums
  static AbsenceStatus? _parseStatus(String? status) {
    if (status == null) return null;
    return AbsenceStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => AbsenceStatus.unjustified,
    );
  }
}
