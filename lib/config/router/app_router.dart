import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/student_dashboard/presentation/pages/student_dashboard_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.login,
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.studentDashboard,
        builder: (context, state) => const StudentDashboardPage(),
      ),
    ],
  );
}
