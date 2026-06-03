part of 'available_sessions_cubit.dart';

sealed class AvailableSessionsState extends Equatable {
  const AvailableSessionsState();

  @override
  List<Object> get props => [];
}

final class AvailableSessionsInitial extends AvailableSessionsState {}

final class AvailableSessionsLoading extends AvailableSessionsState {}

final class AvailableSessionsLoaded extends AvailableSessionsState {
  final List<AvailableSession> sessions;
  const AvailableSessionsLoaded({required this.sessions});
  @override
  List<Object> get props => [sessions];
}

final class AvailableSessionsError extends AvailableSessionsState {
  final String message;
  const AvailableSessionsError({required this.message});
  @override
  List<Object> get props => [message];
}
