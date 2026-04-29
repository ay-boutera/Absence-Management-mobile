import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Absence Management'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorTitle;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the data. Please try again later.'**
  String get errorMessage;

  /// No description provided for @goBackHome.
  ///
  /// In en, this message translates to:
  /// **'Go back to home'**
  String get goBackHome;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @logInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get logInWithGoogle;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to log in to your account'**
  String get signInSubtitle;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @orLogInWith.
  ///
  /// In en, this message translates to:
  /// **'Or log in with'**
  String get orLogInWith;

  /// No description provided for @googleAuth.
  ///
  /// In en, this message translates to:
  /// **'Google Auth'**
  String get googleAuth;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @myTimetable.
  ///
  /// In en, this message translates to:
  /// **'My Timetable'**
  String get myTimetable;

  /// No description provided for @checkTimetable.
  ///
  /// In en, this message translates to:
  /// **'Check your weekly timetable'**
  String get checkTimetable;

  /// No description provided for @absenceWarning.
  ///
  /// In en, this message translates to:
  /// **'You have 2 absences for today.'**
  String get absenceWarning;

  /// No description provided for @todayClasses.
  ///
  /// In en, this message translates to:
  /// **'Today\'s classes'**
  String get todayClasses;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQrCode;

  /// No description provided for @noClassesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Classes Available'**
  String get noClassesAvailable;

  /// No description provided for @noClassesAvailableDescreption.
  ///
  /// In en, this message translates to:
  /// **'It looks like you don’t have any classes scheduled at the moment. This space will be updated as new classes are scheduled!'**
  String get noClassesAvailableDescreption;

  /// No description provided for @subjectLow.
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get subjectLow;

  /// No description provided for @subjectAcsi.
  ///
  /// In en, this message translates to:
  /// **'ACSI'**
  String get subjectAcsi;

  /// No description provided for @subjectBdd.
  ///
  /// In en, this message translates to:
  /// **'BDD'**
  String get subjectBdd;

  /// No description provided for @subjectTdd.
  ///
  /// In en, this message translates to:
  /// **'TDD'**
  String get subjectTdd;

  /// No description provided for @subjectCiCd.
  ///
  /// In en, this message translates to:
  /// **'CI/CD'**
  String get subjectCiCd;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High Priority'**
  String get priorityHigh;

  /// No description provided for @attendanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendanceTitle;

  /// No description provided for @attendanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Check your progress'**
  String get attendanceSubtitle;

  /// No description provided for @checkAbsencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your absences'**
  String get checkAbsencesTitle;

  /// No description provided for @checkAbsencesAction.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get checkAbsencesAction;

  /// No description provided for @overallScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Overall Score'**
  String get overallScoreLabel;

  /// No description provided for @overallScoreGroup.
  ///
  /// In en, this message translates to:
  /// **'Semester Average'**
  String get overallScoreGroup;

  /// No description provided for @semester1.
  ///
  /// In en, this message translates to:
  /// **'Semester 1'**
  String get semester1;

  /// No description provided for @semester2.
  ///
  /// In en, this message translates to:
  /// **'Semester 2'**
  String get semester2;

  /// No description provided for @sessionCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No sessions} =1{1 session} other{{count} sessions}}'**
  String sessionCount(num count);

  /// No description provided for @myAbsencesTitle.
  ///
  /// In en, this message translates to:
  /// **'My absences'**
  String get myAbsencesTitle;

  /// No description provided for @trackManageAbsences.
  ///
  /// In en, this message translates to:
  /// **'Track and manage your absences'**
  String get trackManageAbsences;

  /// No description provided for @totalAbsences.
  ///
  /// In en, this message translates to:
  /// **'Total Absences'**
  String get totalAbsences;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get filterPending;

  /// No description provided for @filterApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get filterApproved;

  /// No description provided for @filterRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get filterRejected;

  /// No description provided for @statusUnjustified.
  ///
  /// In en, this message translates to:
  /// **'Unjustified'**
  String get statusUnjustified;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusJustified.
  ///
  /// In en, this message translates to:
  /// **'Justified'**
  String get statusJustified;

  /// No description provided for @justifyNow.
  ///
  /// In en, this message translates to:
  /// **'Justify now'**
  String get justifyNow;

  /// No description provided for @seeReason.
  ///
  /// In en, this message translates to:
  /// **'See Reason'**
  String get seeReason;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @databaseSystems.
  ///
  /// In en, this message translates to:
  /// **'TD - Database Systems'**
  String get databaseSystems;

  /// No description provided for @machineLearning.
  ///
  /// In en, this message translates to:
  /// **'TP - Machine Learning'**
  String get machineLearning;

  /// No description provided for @computerNetworks.
  ///
  /// In en, this message translates to:
  /// **'TD - Computer Networks'**
  String get computerNetworks;

  /// No description provided for @artificialIntelligence.
  ///
  /// In en, this message translates to:
  /// **'TP - Artificial Intelligence'**
  String get artificialIntelligence;

  /// No description provided for @absenceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Absence Details'**
  String get absenceDetailsTitle;

  /// No description provided for @module.
  ///
  /// In en, this message translates to:
  /// **'Module'**
  String get module;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateAndTime;

  /// No description provided for @professor.
  ///
  /// In en, this message translates to:
  /// **'Professor'**
  String get professor;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Salle'**
  String get room;

  /// No description provided for @justificationRejected.
  ///
  /// In en, this message translates to:
  /// **'Justification Rejected'**
  String get justificationRejected;

  /// No description provided for @certificateInvalidMessage.
  ///
  /// In en, this message translates to:
  /// **'The medical certificate provided is not valid. Please submit an official certificate from a recognized medical institution.'**
  String get certificateInvalidMessage;

  /// No description provided for @uploadNewJustification.
  ///
  /// In en, this message translates to:
  /// **'Upload New Justification'**
  String get uploadNewJustification;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @justifyAbsenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Justify Absence'**
  String get justifyAbsenceTitle;

  /// No description provided for @justifyAbsenceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Submit medical certificates or administrative proof.'**
  String get justifyAbsenceSubtitle;

  /// No description provided for @missedSessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Missed Session(s)'**
  String get missedSessionsLabel;

  /// No description provided for @selectPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'select'**
  String get selectPlaceholder;

  /// No description provided for @reasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reasonLabel;

  /// No description provided for @sickOption.
  ///
  /// In en, this message translates to:
  /// **'Sick'**
  String get sickOption;

  /// No description provided for @evidenceDocumentLabel.
  ///
  /// In en, this message translates to:
  /// **'Evidence Document'**
  String get evidenceDocumentLabel;

  /// No description provided for @clickToUpload.
  ///
  /// In en, this message translates to:
  /// **'Click to upload file'**
  String get clickToUpload;

  /// No description provided for @fileFormatHint.
  ///
  /// In en, this message translates to:
  /// **'Format should be in .pdf .jpeg .png less than 5MB'**
  String get fileFormatHint;

  /// No description provided for @additionalCommentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Comments'**
  String get additionalCommentsLabel;

  /// No description provided for @commentsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Provide details regarding your absence...'**
  String get commentsPlaceholder;

  /// No description provided for @submitJustification.
  ///
  /// In en, this message translates to:
  /// **'Submit Justification'**
  String get submitJustification;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
