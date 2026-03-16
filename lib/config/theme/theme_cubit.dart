import 'package:abs/core/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorageService storage;

  ThemeCubit(this.storage) : super(storage.getThemeMode());

  void changeTheme(ThemeMode mode) {
    storage.setThemeMode(mode);
    emit(mode);
  }
}
