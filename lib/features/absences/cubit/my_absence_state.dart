part of 'my_absence_cubit.dart';

sealed class MyAbsenceState extends Equatable {
  const MyAbsenceState();

  @override
  List<Object> get props => [];
}

final class MyAbsenceInitial extends MyAbsenceState {}

final class MyAbsenceLoading extends MyAbsenceState {}

final class MyAbsenceSuccess extends MyAbsenceState {
  final List<AbsenceItem> absences;
  final List<ModuleStats> modulesStats;
  final double attendanceRate;

  const MyAbsenceSuccess({
    required this.absences,
    required this.modulesStats,
    required this.attendanceRate,
  });

  @override
  List<Object> get props => [absences, modulesStats, attendanceRate];
}

final class MyAbsenceError extends MyAbsenceState {
  final String message;

  const MyAbsenceError({required this.message});

  @override
  List<Object> get props => [message];
}
