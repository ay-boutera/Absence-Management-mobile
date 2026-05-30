class ModuleStats {
  final String moduleName;
  final int totalSessions;
  final int absences;

  ModuleStats({
    required this.moduleName,
    required this.totalSessions,
    required this.absences,
  });

  double get attendanceRate {
    if (totalSessions == 0) {
      return 100.0;
    }

    final attendedSessions = totalSessions - absences;
    return (attendedSessions / totalSessions) * 100.0;
  }

  factory ModuleStats.fromJson(Map<String, dynamic> json) {
    return ModuleStats(
      moduleName: json['module_name'] as String,
      totalSessions: json['total_sessions'] as int,
      absences: json['absences'] as int,
    );
  }
}
