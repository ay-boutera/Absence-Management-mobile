import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/absences/widgets/absence_list.dart';
import 'package:abs/features/absences/widgets/absences_header.dart';
import 'package:abs/features/absences/widgets/filter_tabs.dart';
import 'package:abs/features/absences/widgets/total_absences_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyAbsenceScreen extends StatelessWidget {
  const MyAbsenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // Sample data - replace with your actual data source
    final List<AbsenceItem> absences = [];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AbsencesHeader(),
            TotalAbsencesCard(
              title: l10n.totalAbsences,
              subtitle: l10n.semester1,
              percentage: 0.7,
            ),
            FilterTabs(
              labels: [
                '${l10n.filterAll} (6)',
                l10n.filterPending,
                l10n.filterApproved,
                l10n.filterRejected,
              ],
            ),
            AbsenceList(absences: absences),

            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
