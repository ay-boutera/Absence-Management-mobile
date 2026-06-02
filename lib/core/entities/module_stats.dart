import 'package:abs/config/constants/enums.dart';

class ModuleStats {
  final String moduleName;
  final int totalSessions;
  final int absences;
  final Semester semester;

  ModuleStats({
    required this.moduleName,
    required this.totalSessions,
    required this.absences,
    required this.semester,
  });

  double get getAttendanceRate {
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
      semester: Semester.values.firstWhere((e) => e.name == json['semester']),
    );
  }
}
