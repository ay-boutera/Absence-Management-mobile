import 'package:abs/config/constants/enums.dart';
import 'package:abs/config/router/app_routes.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/features/auth/pages/login_page.dart';
import 'package:abs/features/student_dashboard/presentation/pages/student_dashboard_page.dart';
import 'package:abs/features/students/presentation/pages/student_list_page.dart';
import 'package:abs/shared/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoadingShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return !(current is AuthLoading && previous is AuthLoggedOut);
      },

      listener: (context, state) {
        if (state is AuthLoading && !_isLoadingShown) {
          _isLoadingShown = true;
          Navigator.pushNamed(context, AppRoutes.loading);
        }

        if (state is! AuthLoading && _isLoadingShown) {
          _isLoadingShown = false;
          Navigator.pop(context);
        }

        if (state is AuthError) {
          Navigator.pushNamed(
            context,
            AppRoutes.error,
            arguments: state.message,
          );
        }
      },

      buildWhen: (previous, current) {
        return current is! AuthLoading && current is! AuthError;
      },

      builder: (context, state) {
        Widget child;

        if (state is AuthSuccess) {
          if (state.user.role == UserRole.student) {
            child = const StudentDashboardPage();
          } else {
            child = const StudentListPage();
          }
        } else if (state is AuthLoggedOut) {
          child = const LoginPage();
        } else {
          child = const LoadingScreen();
        }

        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: child,
          ),
        );
      },
    );
  }
}
