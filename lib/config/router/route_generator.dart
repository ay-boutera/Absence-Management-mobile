import 'package:abs/features/auth/pages/login_page.dart';
import 'package:abs/features/auth/pages/splash_screen.dart';
import 'package:abs/features/student_dashboard/presentation/pages/student_dashboard_page.dart';
import 'package:abs/shared/screens/error_screen.dart';
import 'package:abs/shared/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.studentDashboard:
        return MaterialPageRoute(builder: (_) => const StudentDashboardPage());

      case AppRoutes.loading:
        return MaterialPageRoute(builder: (_) => const LoadingScreen());

      case AppRoutes.error:
        return MaterialPageRoute(builder: (_) => ErrorScreen());

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
