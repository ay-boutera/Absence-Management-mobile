// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Absence Management';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get errorTitle => 'An error occurred';

  @override
  String get errorMessage =>
      'An error occurred while loading the data. Please try again later.';

  @override
  String get goBackHome => 'Go back to home';

  @override
  String get signIn => 'Sign in';

  @override
  String get logInWithGoogle => 'Log in with Google';

  @override
  String get logIn => 'Log in';
}
