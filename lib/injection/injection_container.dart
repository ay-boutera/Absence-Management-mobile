import 'package:abs/config/theme/theme_cubit.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/l10n/locale_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/network/api_services.dart';
import '../core/services/local_storage_service.dart';
import '../core/services/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(Dio.new);

  // Core
  sl.registerLazySingleton(() => ApiServices(sl()));
  sl.registerLazySingleton(() => LocalStorageService(sl()));
  sl.registerLazySingleton(() => SecureStorageService(sl()));

  // cubits
  sl.registerLazySingleton(() => ThemeCubit(sl()));
  sl.registerLazySingleton(AuthCubit.new);
  sl.registerLazySingleton(() => LocaleCubit(sl()));
}
