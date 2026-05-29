// nav_bar_cubit.dart
import 'package:bloc/bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(0));

  void goToScreen(int screenIndex) => emit(NavBarState(screenIndex));

  // Simplified to a direct 1:1 mapping
  void onNavTap(int navIndex) {
    emit(NavBarState(navIndex));
  }
}
