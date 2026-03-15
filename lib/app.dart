import 'package:flutter/material.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Absence Management',
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      supportedLocales: AppL10n.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
