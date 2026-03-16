import 'package:abs/config/router/route_generator.dart';
import 'package:abs/config/router/app_routes.dart';
import 'package:abs/config/theme/theme_cubit.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:abs/l10n/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This will now find the Cubit provided in main.dart
    final locale = context.watch<LocaleCubit>().state;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Absence Management',

          // Use the generated class from your ARB files
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          locale: locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,

          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}
