import 'package:abs/core/entities/user_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://absence-management-backend.onrender.com',
);

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _secureStorage = const FlutterSecureStorage();

  Future<void> initApp() async {
    emit(AuthLoading());

    try {
      // 1. Read the tokens from secure local storage
      final accessToken = await _secureStorage.read(key: 'access_token');

      // If there is no access token, the user is not logged in
      if (accessToken == null) {
        emit(AuthError('No active session found. Please log in.'));
        return;
      }

      // (Optional but recommended) Grab refresh token if you want to pass it too
      final refreshToken = await _secureStorage.read(key: 'refresh_token');

      // 2. Reconstruct the Cookie header so the backend recognizes the session
      final cookieParts = <String>[];
      cookieParts.add('access_token=$accessToken');
      if (refreshToken != null) {
        cookieParts.add('refresh_token=$refreshToken');
      }
      final cookieHeader = cookieParts.join('; ');

      // 3. Hit the /auth/me endpoint
      final url = Uri.parse('$baseUrl/api/v1/auth/me');
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json', 'Cookie': cookieHeader},
      );

      if (response.statusCode == 200) {
        // 4. Session is valid! Decode the JSON and map it using your factory
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final user = UserEntity.fromJson(data);

        emit(AuthSuccess(user: user));
        print('User: ${user.program}');
      } else if (response.statusCode == 401) {
        // 5. The token is invalid or expired. Clear the storage.
        await _secureStorage.delete(key: 'access_token');
        await _secureStorage.delete(key: 'refresh_token');
        await _secureStorage.delete(key: 'csrf_token');

        emit(AuthLoggedOut());
      } else {
        emit(AuthLoggedOut());
      }
    } catch (e) {
      print(e.toString());
      emit(AuthError('Network error during startup: ${e.toString()}'));
    }
  }

  void resetToLogin() {
    emit(AuthLoggedOut());
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final url = Uri.parse('$baseUrl/api/v1/auth/login');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'identifier': 'brahmi.ilyess@esi-sba.dz',
          'password': 'ExampleAuth1!',
        }),
      );

      if (response.statusCode == 200) {
        final String? rawCookie = response.headers['set-cookie'];

        if (rawCookie != null) {
          final cookieBlocks = rawCookie.split(',');

          for (final block in cookieBlocks) {
            final nameValuePair = block.split(';').first.trim();

            if (nameValuePair.contains('=')) {
              final equalsIndex = nameValuePair.indexOf('=');
              final key = nameValuePair.substring(0, equalsIndex).trim();
              final value = nameValuePair.substring(equalsIndex + 1).trim();

              await _secureStorage.write(key: key, value: value);
            }
          }
        }

        // THIS IS SO FUCKED UP BUT IT WORKS

        await initApp();

        // final data = jsonDecode(response.body) as Map<String, dynamic>;
        // print('Data: $data');
        // final user = UserEntity.fromJson(data);

        // emit(AuthSuccess(user: user));
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        final errors = data['detail'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['msg']
            : 'Validation error';
        emit(AuthError('Invalid input: $errorMessage'));
      } else {
        emit(AuthError('Login failed. Please check your credentials.'));
      }
    } catch (e) {
      emit(AuthError('An error occurred: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _secureStorage.deleteAll();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
