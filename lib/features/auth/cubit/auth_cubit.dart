import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> initApp() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      emit(
        AuthSuccess(
          user: UserEntity(
            id: '',
            email: '',
            firstName: 'test',
            lastName: 'test',
            role: UserRole.student,
          ),
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void resetToLogin() {
    emit(AuthLoggedOut());
  }

  Future<void> login() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      emit(
        AuthSuccess(
          user: UserEntity(
            id: '',
            email: '',
            firstName: 'test',
            lastName: 'test',
            role: UserRole.teacher,
          ),
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
