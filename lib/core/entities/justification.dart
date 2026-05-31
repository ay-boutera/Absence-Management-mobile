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
}
