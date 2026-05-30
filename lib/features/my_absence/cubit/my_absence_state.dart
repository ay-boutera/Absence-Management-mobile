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

  const MyAbsenceSuccess({required this.absences});

  @override
  List<Object> get props => [absences];
}
