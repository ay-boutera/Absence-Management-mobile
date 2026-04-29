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

  @override
  String get subjectLow => 'LOW';

  @override
  String get subjectAcsi => 'ACSI';

  @override
  String get subjectBdd => 'BDD';

  @override
  String get subjectTdd => 'TDD';

  @override
  String get subjectCiCd => 'CI/CD';

  @override
  String get priorityHigh => 'High Priority';

  @override
  String get attendanceTitle => 'Attendance';

  @override
  String get attendanceSubtitle => 'Check your progress';

  @override
  String get checkAbsencesTitle => 'Check your absences';

  @override
  String get checkAbsencesAction => 'View Details';

  @override
  String get overallScoreLabel => 'Overall Score';

  @override
  String get overallScoreGroup => 'Semester Average';

  @override
  String get semester1 => 'Semester 1';

  @override
  String get semester2 => 'Semester 2';

  @override
  String sessionCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sessions',
      one: '1 session',
      zero: 'No sessions',
    );
    return '$_temp0';
  }

  @override
  String get myAbsencesTitle => 'My absences';

  @override
  String get trackManageAbsences => 'Track and manage your absences';

  @override
  String get totalAbsences => 'Total Absences';

  @override
  String get filterAll => 'All';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterApproved => 'Approved';

  @override
  String get filterRejected => 'Rejected';

  @override
  String get statusUnjustified => 'Unjustified';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusJustified => 'Justified';

  @override
  String get justifyNow => 'Justify now';

  @override
  String get seeReason => 'See Reason';

  @override
  String get review => 'Review';

  @override
  String get databaseSystems => 'TD - Database Systems';

  @override
  String get machineLearning => 'TP - Machine Learning';

  @override
  String get computerNetworks => 'TD - Computer Networks';

  @override
  String get artificialIntelligence => 'TP - Artificial Intelligence';

  @override
  String get absenceDetailsTitle => 'Absence Details';

  @override
  String get module => 'Module';

  @override
  String get dateAndTime => 'Date & Time';

  @override
  String get professor => 'Professor';

  @override
  String get room => 'Salle';

  @override
  String get justificationRejected => 'Justification Rejected';

  @override
  String get certificateInvalidMessage =>
      'The medical certificate provided is not valid. Please submit an official certificate from a recognized medical institution.';

  @override
  String get uploadNewJustification => 'Upload New Justification';

  @override
  String get close => 'Close';
}
