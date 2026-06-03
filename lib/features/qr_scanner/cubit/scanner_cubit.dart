import 'dart:convert';

import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/features/qr_scanner/cubit/scanner_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(const ScannerIdle());
  Future<void> onCodeDetected(String rawValue) async {
    // Prevent triggering multiple times if already loading
    if (state is! ScannerIdle) return;

    emit(const ScannerLoading());

    try {
      // 1. Validate that the scanned string is actually JSON
      try {
        jsonDecode(rawValue);
      } catch (e) {
        emit(const ScannerError('Invalid QR code format.'));
        return;
      }

      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');

      if (token == null) {
        emit(const ScannerError('Session expired. Please log in again.'));
        return;
      }

      final uri = Uri.parse('$baseUrl/api/v1/attendance/mark-present');

      final response = await http.post(
        uri,
        body: rawValue, // Sending the raw JSON string directly
        headers: {
          'Accept': 'application/json',
          'Content-Type':
              'application/json', // <-- Crucial for sending JSON bodies
          'Authorization': 'Bearer $token',
        },
      );

      // 2. Handle HTTP Status Codes
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(const ScannerSuccess());
      } else {
        // 3. Attempt to parse the error message from the backend
        String errorMessage = 'Failed to mark attendance.';
        try {
          final errorData = jsonDecode(response.body);
          // Assuming your backend uses FastAPI/Python, errors are usually in 'detail'
          if (errorData['detail'] != null) {
            errorMessage = errorData['detail'].toString();
          }
        } catch (_) {
          // Fallback if the response isn't JSON
          errorMessage = 'Server error: ${response.statusCode}';
        }

        emit(ScannerError(errorMessage));
      }
    } on Exception catch (e) {
      emit(ScannerError('Network error: ${e.toString()}'));
    }
  }

  /// Resets back to idle so the next scan can be processed.
  void goBackToScanner() => emit(const ScannerIdle());
}
