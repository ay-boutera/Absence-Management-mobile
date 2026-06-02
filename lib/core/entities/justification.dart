class Justification {
  final String scopeType; // 'absence' | 'session' | 'range'
  final String reason;
  final String documentPath; // local file path
  final String? absenceId;
  final String? sessionId;
  final String? startDate; // 'yyyy-MM-dd'
  final String? endDate; // 'yyyy-MM-dd'

  Justification({
    required this.scopeType,
    required this.reason,
    required this.documentPath,
    this.absenceId,
    this.sessionId,
    this.startDate,
    this.endDate,
  });

  /// Converts the [Justification] instance into a Map.
  Map<String, dynamic> toMap() {
    return {
      'scope_type': scopeType,
      'reason': reason,
      'document_path': documentPath,
      if (absenceId != null) 'absence_id': absenceId,
      if (sessionId != null) 'session_id': sessionId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    };
  }

  /// Creates a [Justification] instance from a Map.
  factory Justification.fromMap(Map<String, dynamic> map) {
    return Justification(
      scopeType: map['scope_type'] as String,
      reason: map['reason'] as String,
      documentPath: map['document_path'] as String,
      absenceId: map['absence_id'] as String?,
      sessionId: map['session_id'] as String?,
      startDate: map['start_date'] as String?,
      endDate: map['end_date'] as String?,
    );
  }
}
