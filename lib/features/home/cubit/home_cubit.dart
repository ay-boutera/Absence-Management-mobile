import 'package:abs/core/entities/session_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final String baseUrl = "https://absence-management-backend.onrender.com";

  List<SessionEntity> _sessions = [];

  Future<void> fetchMySessions() async {
    if (isClosed) return;
    emit(HomeLoading());
    try {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'access_token');
      print(token);

      if (token == null) {
        emit(const HomeError(message: 'No access token found'));
        return;
      }

      final uri = Uri.parse('$baseUrl/api/v1/planning/my-schedule');

      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        _sessions = (data['sessions'] as List)
            .map((json) => SessionEntity.fromJson(json))
            .toList();

        final String? todayName = frenchWeekdays[DateTime.now().weekday];

        final today = _sessions
            .where((session) => session.day == todayName)
            .toList();

        emit(HomeLoadedSuccess(sessions: today));
      } else {
        emit(
          HomeError(
            message: 'Failed to load schedule (${response.statusCode})',
          ),
        );
      }
    } catch (e) {
      print(e.toString());
      emit(HomeError(message: e.toString()));
    }
  }

  void changeSelectedDay(String day) {
    if (state is! HomeLoadedSuccess) return;

    final sessions = _sessions.where((session) => session.day == day).toList();
    emit(HomeLoadedSuccess(sessions: sessions));
  }
}

const frenchWeekdays = {
  1: "Lundi",
  2: "Mardi",
  3: "Mercredi",
  4: "Jeudi",
  5: "Vendredi",
  6: "Samedi",
  7: "Dimanche",
};
