import 'package:abs/config/constants/enums.dart';
import 'package:flutter/material.dart';

class AbsenceItem {
  final String absenceId;
  final String sessionId;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String moduleName;
  final String teacherName;
  final bool isAbsent;
  final AbsenceStatus? justificationStatus;
  final String sessionGroup;
  final bool isOwnGroup;
  final bool isCrossSession;

  AbsenceItem({
    required this.absenceId,
    required this.sessionId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.moduleName,
    required this.teacherName,
    required this.isAbsent,
    this.justificationStatus,
    required this.sessionGroup,
    required this.isOwnGroup,
    required this.isCrossSession,
  });

  Color getStatusColor(ThemeData theme) {
    switch (justificationStatus) {
      case AbsenceStatus.rejected:
        return theme.colorScheme.error;
      case AbsenceStatus.pending:
        return Colors.amber[700]!;
      case AbsenceStatus.justified:
        return Colors.green[700]!;
      case AbsenceStatus.unjustified:
      case null: // Default styling if status is null
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
      case null:
        return 'No Status';
    }
  }

  factory AbsenceItem.fromJson(Map<String, dynamic> json) {
    return AbsenceItem(
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

  // Helper helper method to map incoming strings securely to your enums
  static AbsenceStatus? _parseStatus(String? status) {
    if (status == null) return null;
    return AbsenceStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => AbsenceStatus.unjustified,
    );
  }
}
