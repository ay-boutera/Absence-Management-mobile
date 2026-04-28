// nav_bar_cubit.dart
import 'package:bloc/bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(0));

  void goToScreen(int screenIndex) => emit(NavBarState(screenIndex));

  void onNavTap(int navIndex) {
    emit(NavBarState(_navIndexToScreenIndex(navIndex)));
  }

  int _navIndexToScreenIndex(int navIndex) {
    return navIndex < 2 ? navIndex : navIndex + 1;
  }
}
