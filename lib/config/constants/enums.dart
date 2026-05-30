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

enum AbsenceStatus { unjustified, rejected, pending, justified }

enum DocumentType { none, pdf, png, jpeg, jpg }
