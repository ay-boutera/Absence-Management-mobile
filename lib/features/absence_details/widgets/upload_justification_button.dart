import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/justify_absence/screens/justify_absence_page.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UploadJustificationButton extends StatelessWidget {
  const UploadJustificationButton({super.key, required this.absence});

  final AbsenceItem absence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JustifyAbsencePage(absence: absence),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
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
  }
}
