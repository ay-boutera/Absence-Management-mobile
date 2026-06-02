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

  @override
  String get justifyAbsenceTitle => 'Justify Absence';

  @override
  String get justifyAbsenceSubtitle =>
      'Submit medical certificates or administrative proof.';

  @override
  String get missedSessionsLabel => 'Missed Session(s)';

  @override
  String get selectPlaceholder => 'select';

  @override
  String get reasonLabel => 'Reason';

  @override
  String get sickOption => 'Sick';

  @override
  String get evidenceDocumentLabel => 'Evidence Document';

  @override
  String get clickToUpload => 'Click to upload file';

  @override
  String get fileFormatHint =>
      'Format should be in .pdf .jpeg .png less than 5MB';

  @override
  String get additionalCommentsLabel => 'Additional Comments';

  @override
  String get commentsPlaceholder => 'Provide details regarding your absence...';

  @override
  String get submitJustification => 'Submit Justification';

  @override
  String get examScheduleTitle => 'Exam schedule';

  @override
  String get examScheduleSubtitle => 'Check your rattrapage exams schedule';

  @override
  String get noExamsTitle => 'There is no exams for the moment !';

  @override
  String get examsStartDate => 'Exams start 7 January 2026';

  @override
  String get studentName => 'Bouhafs Rim';

  @override
  String get studentLevel => '1CS Student';

  @override
  String get operations => 'Operations';

  @override
  String get myInformation => 'My information';

  @override
  String get timeTable => 'Time table';

  @override
  String get examsSchedule => 'Exams schedule';

  @override
  String get attendancePerformance => 'Attendance performance';

  @override
  String get notifications => 'Notifications';

  @override
  String get account => 'Account';

  @override
  String get changePassword => 'Change your password';

  @override
  String get language => 'Language';

  @override
  String get contactEsi => 'Contact ESI';

  @override
  String get contact => 'Contact';

  @override
  String get email => 'Email';

  @override
  String get website => 'Website';

  @override
  String get address => 'Address';

  @override
  String get logOut => 'Log Out';

  @override
  String get preferences => 'Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get myInfo => 'My info';

  @override
  String get matriculeLabel => 'Matricule';

  @override
  String get schoolAddress =>
      'Ecole superieure en informatique 08 mai 1945 , Sidi Bel Abbes , Algeria';

  @override
  String get notRegistered => 'Not registered';

  @override
  String get status => 'Status';

  @override
  String get unjustified => 'Unjustified';

  @override
  String get rejected => 'Rejected';

  @override
  String get pending => 'Pending';

  @override
  String get justified => 'Justified';

  @override
  String get familyEmergency => 'Family Emergency';

  @override
  String get other => 'Other';

  @override
  String get filterJustified => 'Justified';

  @override
  String get absences => 'Absences';

  @override
  String get enterYourInformation => 'Enter your information';

  @override
  String get currentPassword => 'currentPassword';

  @override
  String get newPassword => 'newPassword';

  @override
  String get confirmNewPassword => 'confirmNewPassword';

  @override
  String get oldPasswordHint => 'Enter your old password';

  @override
  String get newPasswordHint => 'Enter your new password';

  @override
  String get confirmPasswordHint => 'Confirm your new password';

  @override
  String get passwordMustBeAtLeast8Characters =>
      'Password must be at least 8 characters';

  @override
  String get passwordMustContainAtLeastOneUppercaseLetter =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordMustContainAtLeastOneLowercaseLetter =>
      'Password must contain at least one lowercase letter';

  @override
  String get passwordMustContainAtLeastOneNumber =>
      'Password must contain at least one number';

  @override
  String get passwordMustContainAtLeastOneSpecialCharacter =>
      'Password must contain at least one special character';

  @override
  String get pleaseFillInAllFields => 'Please fill in all fields';

  @override
  String get newPasswordsDoNotMatch => 'New passwords do not match';

  @override
  String get noAccessTokenFound => 'No access token found';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get invalidInputPleaseCheckYourFields =>
      'Invalid input. Please check your fields.';

  @override
  String get failedToChangePassword => 'Failed to change password';

  @override
  String get anErrorOccurred => 'An error occurred';

  @override
  String get ok => 'Ok';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get scanQrCodeTitle => 'Scan QR Code';

  @override
  String get scanQrCodeSubtitle => 'Point your camera at a QR code to scan';

  @override
  String get noAbsences => 'No absences';

  @override
  String get attendanceWithAnotherGroup => 'Attend with another group';
}
