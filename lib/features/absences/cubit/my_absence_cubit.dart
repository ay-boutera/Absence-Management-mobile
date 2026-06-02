import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/core/entities/justification.dart';
import 'package:abs/core/entities/module_stats.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

part 'my_absence_state.dart';

class MyAbsenceCubit extends Cubit<MyAbsenceState> {
  MyAbsenceCubit() : super(MyAbsenceInitial());

  List<AbsenceItem> _allAbsences = [];
  List<ModuleStats> _modulesStats = [];
  double _attendanceRate = 0.0;

  double get attendanceRate => _attendanceRate;

  Future<void> getAbsences() async {
    emit(MyAbsenceLoading());
    try {
      const storage = FlutterSecureStorage();

      final token = (await storage.read(key: 'access_token'))?.trim();
      final refreshToken = await storage.read(key: 'refresh_token');
      final csrfToken = await storage.read(key: 'csrf_token');

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
          'Cookie':
              'access_token=$token; refresh_token=$refreshToken; csrf_token=$csrfToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        _allAbsences = (data['absence_history'] as List)
            .map((json) => AbsenceItem.fromJson(json))
            .toList();

        _modulesStats = (data['module_attendance'] as List)
            .map((json) => ModuleStats.fromJson(json))
            .toList();

        print(_modulesStats.length);

        _attendanceRate = data['attendance_rate'] as double;

        emit(
          MyAbsenceSuccess(
            absences: _allAbsences,
            modulesStats: _modulesStats,
            attendanceRate: _attendanceRate,
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

  void filterAbsencesByState(AbsenceStatus? status) {
    if (state is! MyAbsenceSuccess) return;

    final filteredAbsences = status == null
        ? _allAbsences
        : _allAbsences
              .where((absence) => absence.justificationStatus == status)
              .toList();
    emit(
      MyAbsenceSuccess(
        absences: filteredAbsences,
        modulesStats: _modulesStats,
        attendanceRate: _attendanceRate,
      ),
    );
  }

  Future<void> submitJustification(Justification justification) async {
    // Keep existing data visible while submitting
    if (state is MyAbsenceSuccess) {
      final current = state as MyAbsenceSuccess;
      emit(
        MyAbsenceSubmitting(
          absences: current.absences,
          modulesStats: current.modulesStats,
          attendanceRate: current.attendanceRate,
        ),
      );
    }

    try {
      const storage = FlutterSecureStorage();
      final token = (await storage.read(key: 'access_token'))?.trim();
      final refreshToken = await storage.read(key: 'refresh_token');
      final csrfToken = await storage.read(key: 'csrf_token');

      if (token == null) {
        emit(const MyAbsenceError(message: 'No access token found'));
        return;
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://absence-management-backend.onrender.com/api/v1/justifications',
        ),
      );

      request.headers.addAll({
        'accept': 'application/json',
        'Cookie':
            'access_token=$token; refresh_token=$refreshToken; csrf_token=$csrfToken',
      });

      request.fields['scope_type'] = justification.scopeType;
      request.fields['reason'] = justification.reason;

      if (justification.absenceId != null) {
        request.fields['absence_id'] = justification.absenceId!;
      }
      if (justification.sessionId != null) {
        request.fields['session_id'] = justification.sessionId!;
      }
      if (justification.startDate != null) {
        request.fields['start_date'] = justification.startDate!;
      }
      if (justification.endDate != null) {
        request.fields['end_date'] = justification.endDate!;
      }

      final mimeType =
          lookupMimeType(justification.documentPath) ??
          'application/octet-stream';
      final mimeParts = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'document',
          justification.documentPath,
          contentType: http.MediaType(mimeParts[0], mimeParts[1]),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        await getAbsences();
      } else if (response.statusCode == 409) {
        emit(
          const MyAbsenceError(
            message: 'Justification already submitted for this absence',
          ),
        );
      } else if (response.statusCode == 404) {
        emit(const MyAbsenceError(message: 'Absence or session not found'));
      } else if (response.statusCode == 400) {
        emit(const MyAbsenceError(message: 'Invalid file or request data'));
      } else {
        emit(
          MyAbsenceError(
            message: 'Failed to submit justification (${response.statusCode})',
          ),
        );
      }
    } catch (e) {
      emit(MyAbsenceError(message: e.toString()));
    }
  }
}
