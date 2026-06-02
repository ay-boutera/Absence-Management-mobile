import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifations_state.dart';

class NotifationsCubit extends Cubit<NotifationsState> {
  NotifationsCubit() : super(NotifationsInitial());
}
