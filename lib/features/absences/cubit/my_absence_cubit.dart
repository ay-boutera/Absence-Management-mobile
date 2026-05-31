import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/core/entities/module_stats.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

part 'my_absence_state.dart';

class MyAbsenceCubit extends Cubit<MyAbsenceState> {
  MyAbsenceCubit() : super(MyAbsenceInitial());

  Future<void> getAbsences() async {
    emit(MyAbsenceLoading());
    try {
      const storage = FlutterSecureStorage();
      final token = (await storage.read(key: 'access_token'))?.trim();
      final csrfToken = (await storage.read(key: 'csrf_token'))?.trim();
      final cookie = await storage.read(key: 'auth_cookie');

      if (token == null) {
        emit(const MyAbsenceError(message: 'No access token found'));
        return;
      }

      final response = await http.get(
        Uri.parse(
          'https://absence-management-backend.onrender.com/api/v1/students/me',
        ),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'X-CSRF-Token': csrfToken ?? '',
          if (cookie != null) 'Cookie': cookie,
        },
      );

      print('Status: ${response.statusCode}');
      print('Headers sent: Authorization: Bearer $token');
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        final absences = (data['absence_history'] as List)
            .map((json) => AbsenceItem.fromJson(json))
            .toList();

        final modulesStats = (data['module_attendance'] as List)
            .map((json) => ModuleStats.fromJson(json))
            .toList();

        final attendanceRate = data['attendance_rate'] as double;

        emit(
          MyAbsenceSuccess(
            absences: absences,
            modulesStats: modulesStats,
            attendanceRate: attendanceRate,
          ),
        );
      } else {
        print('Failed to load absences: ${response.body}');

        emit(
          MyAbsenceError(
            message: 'Failed to load absences (${response.statusCode})',
          ),
        );
      }
    } catch (e) {
      print('Failed to load absences: $e');
      emit(MyAbsenceError(message: e.toString()));
    }
  }
}
