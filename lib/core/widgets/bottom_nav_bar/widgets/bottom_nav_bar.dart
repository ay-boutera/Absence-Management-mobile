import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/core/widgets/bottom_nav_bar/widgets/nav_icon.dart';
import 'package:abs/features/home/screens/home_page.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/core/widgets/bottom_nav_bar/cubit/nav_bar_cubit.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// TEMP screens for worker
class TestScreen extends StatelessWidget {
  final String title;
  const TestScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          if (title == 'Worker Profile') {
            context.read<AuthCubit>().signOut();
          }
        },
        child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavBarCubit(),
      child: _BottomNavBarView(userEntity: userEntity),
    );
  }
}

class _BottomNavBarView extends StatelessWidget {
  const _BottomNavBarView({required this.userEntity});

  final UserEntity userEntity;

  List<String> _getLabels(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [l10n.home, l10n.schedule, l10n.attendance, l10n.more];
  }

  int? _screenIndexToNavIndex(int screenIndex) {
    if (screenIndex == 2) return null;
    return screenIndex < 2 ? screenIndex : screenIndex - 1;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final labels = _getLabels(context);

    final List<Widget> screens = [
      const HomePage(),
      TestScreen('title 2'),
      TestScreen('title 3'),
      TestScreen('title 4'),
      TestScreen('title 5'),
    ];

    final List<String> iconPaths = [
      AppAssets.home,
      AppAssets.schedule,
      AppAssets.attendance,
      AppAssets.more,
    ];

    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        final currentIndex = state.screenIndex;
        final activeNavIndex = _screenIndexToNavIndex(
          currentIndex,
          // isWorker: isWorker,
        );
        final cubit = context.read<NavBarCubit>();

        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: currentIndex, children: screens),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const TestScreen(''),
              );
            },
            shape: const CircleBorder(),
            backgroundColor: colorScheme.primary,
            child: NavIcon(
              assetPath: AppAssets.scanner,
              isActive: true,
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: Directionality(
            textDirection: TextDirection.ltr,
            child: AnimatedBottomNavigationBar.builder(
              itemCount: iconPaths.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.4);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavIcon(
                      assetPath: iconPaths[index],
                      isActive: isActive,
                      activeColor: colorScheme.primary,
                      inactiveColor: colorScheme.onSurface.withValues(
                        alpha: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: color,
                      ),
                    ),
                  ],
                );
              },
              backgroundColor: colorScheme.surface,
              activeIndex: activeNavIndex ?? -1,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 22,
              rightCornerRadius: 22,
              splashColor: colorScheme.primary.withAlpha(30),
              onTap: cubit.onNavTap,
            ),
          ),
        );
      },
    );
  }
}
