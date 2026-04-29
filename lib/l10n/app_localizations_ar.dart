// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'إدارة الغياب';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get errorTitle => 'حدث خطأ';

  @override
  String get errorMessage =>
      'حدث خطأ أثناء تحميل البيانات. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get goBackHome => 'العودة إلى الشاشة الرئيسية';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get logInWithGoogle => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get signInSubtitle =>
      'أدخل بريدك الإلكتروني وكلمة المرور لتسجيل الدخول';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get orLogInWith => 'أو تسجيل الدخول باستخدام';

  @override
  String get googleAuth => 'جوجل';

  @override
  String get home => 'الرئيسية';

  @override
  String get schedule => 'الجدول';

  @override
  String get attendance => 'الحضور';

  @override
  String get more => 'المزيد';

  @override
  String get myTimetable => 'جدولي';

  @override
  String get checkTimetable => 'تحقق من جدولك الأسبوعي';

  @override
  String get absenceWarning => 'لديك غيابان لهذا اليوم.';

  @override
  String get todayClasses => 'حصص اليوم';

  @override
  String get scanQrCode => 'مسح رمز الاستجابة السريعة';

  @override
  String get noClassesAvailable => 'لا يوجد حصص اليوم';

  @override
  String get noClassesAvailableDescreption =>
      'يبدو أنه ليس لديك أي دروس مجدولة في الوقت الحالي. سيتم تحديث هذه المساحة عند جدولة دروس جديدة!';

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
  String get priorityHigh => 'أولوية قصوى';

  @override
  String get attendanceTitle => 'الحضور';

  @override
  String get attendanceSubtitle => 'تحقق من تقدمك';

  @override
  String get checkAbsencesTitle => 'تحقق من الغيابات';

  @override
  String get checkAbsencesAction => 'عرض التفاصيل';

  @override
  String get overallScoreLabel => 'النتيجة الإجمالية';

  @override
  String get overallScoreGroup => 'متوسط الفصل الدراسي';

  @override
  String get semester1 => 'الفصل الأول';

  @override
  String get semester2 => 'الفصل الثاني';

  @override
  String sessionCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حصص',
      two: 'حصتان',
      one: 'حصة واحدة',
      zero: 'لا توجد حصص',
    );
    return '$_temp0';
  }

  @override
  String get myAbsencesTitle => 'غياباتي';

  @override
  String get trackManageAbsences => 'تتبع وإدارة غياباتك';

  @override
  String get totalAbsences => 'إجمالي الغيابات';

  @override
  String get filterAll => 'الكل';

  @override
  String get filterPending => 'قيد الانتظار';

  @override
  String get filterApproved => 'مقبول';

  @override
  String get filterRejected => 'مرفوض';

  @override
  String get statusUnjustified => 'غير مبرر';

  @override
  String get statusRejected => 'مرفوض';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusJustified => 'مبرر';

  @override
  String get justifyNow => 'برر الآن';

  @override
  String get seeReason => 'انظر السبب';

  @override
  String get review => 'مراجعة';

  @override
  String get databaseSystems => 'تطبيق - قواعد البيانات';

  @override
  String get machineLearning => 'تمرين - تعلم الآلة';

  @override
  String get computerNetworks => 'تطبيق - شبكات الحاسوب';

  @override
  String get artificialIntelligence => 'تمرين - الذكاء الاصطناعي';

  @override
  String get absenceDetailsTitle => 'تفاصيل الغياب';

  @override
  String get module => 'المقياس';

  @override
  String get dateAndTime => 'التاريخ والوقت';

  @override
  String get professor => 'الأستاذ';

  @override
  String get room => 'القاعة';

  @override
  String get justificationRejected => 'تم رفض التبرير';

  @override
  String get certificateInvalidMessage =>
      'الشهادة الطبية المقدمة غير صالحة. يرجى تقديم شهادة رسمية من مؤسسة طبية معتمدة.';

  @override
  String get uploadNewJustification => 'رفع تبرير جديد';

  @override
  String get close => 'إغلاق';

  @override
  String get justifyAbsenceTitle => 'تبرير الغياب';

  @override
  String get justifyAbsenceSubtitle =>
      'يرجى تقديم الشهادات الطبية أو الإثباتات الإدارية.';

  @override
  String get missedSessionsLabel => 'الحصة (الحصص) المتغيب عنها';

  @override
  String get selectPlaceholder => 'اختر';

  @override
  String get reasonLabel => 'السبب';

  @override
  String get sickOption => 'مرض';

  @override
  String get evidenceDocumentLabel => 'وثيقة الإثبات';

  @override
  String get clickToUpload => 'اضغط لرفع الملف';

  @override
  String get fileFormatHint =>
      'يجب أن يكون التنسيق .pdf أو .jpeg أو .png وبحجم أقل من 5 ميجابايت';

  @override
  String get additionalCommentsLabel => 'تعليقات إضافية';

  @override
  String get commentsPlaceholder => 'قدم تفاصيل بخصوص غيابك...';

  @override
  String get submitJustification => 'إرسال التبرير';

  @override
  String get examScheduleTitle => 'جدول الامتحانات';

  @override
  String get examScheduleSubtitle =>
      'تحقق من جدول امتحانات الاستدراك الخاصة بك';

  @override
  String get noExamsTitle => 'لا توجد امتحانات في الوقت الحالي!';

  @override
  String get examsStartDate => 'تبدأ الامتحانات في 7 جانفي 2026';
}
