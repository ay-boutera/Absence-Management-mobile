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
}
