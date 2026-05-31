class Teacher {
  final String id;
  final String employeeId;
  final String firstName;
  final String lastName;

  Teacher({
    required this.id,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
