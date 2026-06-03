class AvailableSession {
  final String sessionId;
  final String date;
  final String startTime;
  final String endTime;
  final String room;
  final String teacherName;
  final String moduleName;

  AvailableSession({
    required this.sessionId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.teacherName,
    required this.moduleName,
  });

  factory AvailableSession.fromJson(Map<String, dynamic> json) {
    return AvailableSession(
      // Using 'as String?' and providing a fallback handles cases where the API might return null for a field
      sessionId: json['session_id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      room: json['room'] as String? ?? 'N/A',
      teacherName: json['teacher_name'] as String? ?? 'Unknown',
      moduleName: json['module_name'] as String? ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'room': room,
      'teacher_name': teacherName,
      'module_name': moduleName,
    };
  }
}
