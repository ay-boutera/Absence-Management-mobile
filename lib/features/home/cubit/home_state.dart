part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadedSuccess extends HomeState {
  final List<SessionEntity> sessions;

  const HomeLoadedSuccess({required this.sessions});

  @override
  List<Object> get props => [sessions];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
