import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  final LocalStorageService storage;

  LocaleCubit(this.storage) : super(_initialLocale(storage));

  static Locale _initialLocale(LocalStorageService storage) {
    final languageCode = storage.getLanguage();
    return Locale(languageCode);
  }

  void changeLocale(Locale locale, String userId, UserRole userType) {
    if (state.languageCode == locale.languageCode) return;
  }
}
