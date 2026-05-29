import 'package:abs/config/theme/theme_cubit.dart';
import 'package:abs/features/profile/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void changeThemeBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return ThemeToggleButton(
              currentThemeMode: themeMode,
              onChanged: (ThemeMode newThemeMode) {
                context.read<ThemeCubit>().changeTheme(newThemeMode);
              },
            );
          },
        ),
      );
    },
  );
}
