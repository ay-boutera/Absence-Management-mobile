import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:abs/features/justify_absence/screens/justify_absence_page.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadJustificationButton extends StatelessWidget {
  const UploadJustificationButton({super.key, required this.absence});

  final AbsenceEntity absence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<MyAbsenceCubit, MyAbsenceState>(
      builder: (context, state) {
        final isLoading = state is MyAbsenceLoading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<MyAbsenceCubit>(),
                            child: JustifyAbsencePage(absence: absence),
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                disabledBackgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onPrimary,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      absence.justificationStatus == AbsenceStatus.rejected
                          ? l10n.uploadNewJustification
                          : l10n.justifyNow,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
