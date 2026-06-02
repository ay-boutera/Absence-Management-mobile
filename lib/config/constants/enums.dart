import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum UserRole {
  student,
  teacher;

  factory UserRole.fromString(String role) {
    switch (role.toLowerCase()) {
      case 'teacher':
        return UserRole.teacher;
      case 'student':
      default:
        return UserRole.student;
    }
  }
}

enum AbsenceStatus {
  unjustified,
  rejected,
  pending,
  approved;

  String toDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    switch (this) {
      case AbsenceStatus.unjustified:
        return l10n.unjustified;
      case AbsenceStatus.rejected:
        return l10n.rejected;
      case AbsenceStatus.pending:
        return l10n.pending;
      case AbsenceStatus.approved:
        return l10n.justified;
    }
  }
}

enum DocumentType { none, pdf, png, jpeg, jpg }

enum NotificationType {
  attendanceRecorded,
  markedAbsent,
  justificationSubmitted,
  justificationApproved,
  justificationRejected,
  classCancelled,
  scheduleUpdated,
}

enum Scope { absence, session, range }

enum Semester { S1, S2 }
