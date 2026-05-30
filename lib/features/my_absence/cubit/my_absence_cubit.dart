import 'package:abs/core/entities/Absence_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_absence_state.dart';

class MyAbsenceCubit extends Cubit<MyAbsenceState> {
  MyAbsenceCubit() : super(MyAbsenceInitial());
}
