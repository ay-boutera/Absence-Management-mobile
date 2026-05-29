import 'package:abs/features/profile/widgets/language_toggle_button.dart';
import 'package:abs/l10n/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void changeLanguageBottomSheet(BuildContext context) {
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
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return LanguageToggleButton(
              currentLocale: locale,
              onChanged: (Locale newLocale) {
                context.read<LocaleCubit>().changeLocale(newLocale);
              },
            );
          },
        ),
      );
    },
  );
}
