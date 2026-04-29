class SubjectAttendanceEntity {
  const SubjectAttendanceEntity({
    required this.title,
    required this.sessions,
    required this.percentage,
    this.subtitle,
  });

  final String title;
  final int sessions;
  final int percentage;

  final String? subtitle;

  String getFactor() {
    final double numberOfPresentSessions = (sessions * percentage) / 100;

    return '${numberOfPresentSessions.round()} / $sessions';
  }
}
