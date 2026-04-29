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

  @override
  String get signInSubtitle =>
      'Enter your email and password to log in to your account';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get orLogInWith => 'Or log in with';

  @override
  String get googleAuth => 'Google Auth';

  @override
  String get home => 'Home';

  @override
  String get schedule => 'Schedule';

  @override
  String get attendance => 'Attendance';

  @override
  String get more => 'More';

  @override
  String get myTimetable => 'My Timetable';

  @override
  String get checkTimetable => 'Check your weekly timetable';

  @override
  String get absenceWarning => 'You have 2 absences for today.';

  @override
  String get todayClasses => 'Today\'s classes';

  @override
  String get scanQrCode => 'Scan QR code';

  @override
  String get noClassesAvailable => 'No Classes Available';

  @override
  String get noClassesAvailableDescreption =>
      'It looks like you don’t have any classes scheduled at the moment. This space will be updated as new classes are scheduled!';
}
