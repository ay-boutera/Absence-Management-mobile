import 'package:abs/features/absence_details/widgets/detail_row.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AbsenceInfoCard extends StatelessWidget {
  const AbsenceInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DetailRow(
              icon: Icons.book_outlined,
              label: l10n.module,
              value: 'TD - Database Systems',
            ),
            DetailRow(
              icon: Icons.calendar_today_outlined,
              label: l10n.dateAndTime,
              value: 'March 20, 2026 - 10:00 AM - 12:00 PM',
            ),
            DetailRow(
              icon: Icons.people_outline,
              label: l10n.professor,
              value: 'Dr. Nabil Keskes',
            ),
            DetailRow(
              icon: Icons.location_on_outlined,
              label: l10n.room,
              value: 'Salle A2 - sup',
              hasDivider: false, // Remove divider for last item
            ),
          ],
        ),
      ),
    );
  }
}
