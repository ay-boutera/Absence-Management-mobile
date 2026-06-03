import 'dart:convert';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:abs/core/entities/available_session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'available_sessions_state.dart';

class AvailableSessionsCubit extends Cubit<AvailableSessionsState> {
  AvailableSessionsCubit() : super(AvailableSessionsInitial());

  // 1. Accept the moduleId as a required parameter
  Future<void> getAvailableSessions(String moduleId) async {
    emit(AvailableSessionsLoading());

    try {
      // 2. Retrieve the JWT from secure storage
      const storage = FlutterSecureStorage();

      final token = (await storage.read(key: 'access_token'))?.trim();
      final refreshToken = await storage.read(key: 'refresh_token');
      final csrfToken = await storage.read(key: 'csrf_token');

      if (token == null) {
        emit(
          const AvailableSessionsError(
            message: 'Session expired. Please log in again.',
          ),
        );
        return;
      }

      // 3. Construct the URI with the module_id query parameter
      final uri = Uri.parse(
        '$baseUrl/api/v1/compensation-requests/available-sessions?module_id=$moduleId',
      );

      // 4. Perform the GET request
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Cookie':
              'access_token=$token; refresh_token=$refreshToken; csrf_token=$csrfToken',
        },
      );

      // 5. Handle the response
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];

        // Map the JSON list to a list of AvailableSession objects
        final sessions = data
            .map(
              (json) => AvailableSession.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        emit(AvailableSessionsLoaded(sessions: sessions));
      } else {
        // Attempt to parse validation/FastAPI detail errors
        String errorMessage = 'Failed to load available sessions.';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['detail'] != null) {
            errorMessage = errorData['detail'].toString();
          }
        } catch (_) {
          errorMessage = 'Server error: ${response.statusCode}';
        }

        emit(AvailableSessionsError(message: errorMessage));
      }
    } on Exception catch (e) {
      emit(AvailableSessionsError(message: 'Network error: ${e.toString()}'));
    }
  }
}
