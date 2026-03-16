import 'package:abs/features/auth/presentation/pages/login_page.dart';
import 'package:abs/features/student_dashboard/presentation/pages/student_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.studentDashboard:
        return MaterialPageRoute(builder: (_) => const StudentDashboardPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
