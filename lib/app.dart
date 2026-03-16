import 'package:abs/config/router/route_generator.dart.dart';
import 'package:abs/config/router/app_routes.dart.dart';
import 'package:flutter/material.dart';
import 'config/theme/app_theme.dart';
import 'l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absence Management',
      theme: AppTheme.lightTheme,
      supportedLocales: AppL10n.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
