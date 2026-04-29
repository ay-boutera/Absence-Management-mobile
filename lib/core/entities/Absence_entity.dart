import 'package:abs/config/constants/enums.dart';
import 'package:flutter/material.dart';

class AbsenceItem {
  final String id;
  final String title;
  final DateTime date;
  final int currentCount;
  final int totalCount;
  final AbsenceStatus status;
  final DocumentType documentType;
  final String? documentName;

  AbsenceItem({
    required this.id,
    required this.title,
    required this.date,
    required this.currentCount,
    required this.totalCount,
    required this.status,
    this.documentType = DocumentType.none,
    this.documentName,
  });

  Color getStatusColor(ThemeData theme) {
    switch (status) {
      case AbsenceStatus.unjustified:
        return theme.colorScheme.onSurface;
      case AbsenceStatus.rejected:
        return theme.colorScheme.error;
      case AbsenceStatus.pending:
        return Colors.amber[700]!;
      case AbsenceStatus.justified:
        return Colors.green[700]!;
    }
  }

  String get statusText {
    switch (status) {
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
}
