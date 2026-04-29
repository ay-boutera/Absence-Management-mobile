import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/my_absence/widgets/absence_list.dart';
import 'package:abs/features/my_absence/widgets/absences_header.dart';
import 'package:abs/features/my_absence/widgets/filter_tabs.dart';
import 'package:abs/features/my_absence/widgets/total_absences_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyAbsenceScreen extends StatelessWidget {
  const MyAbsenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // Sample data - replace with your actual data source
    final absences = [
      AbsenceItem(
        id: '1',
        title: l10n.databaseSystems,
        date: DateTime(2026, 10, 12),
        currentCount: 3,
        totalCount: 5,
        status: AbsenceStatus.unjustified,
        documentType: DocumentType.none,
      ),
      AbsenceItem(
        id: '2',
        title: l10n.machineLearning,
        date: DateTime(2026, 11, 1),
        currentCount: 2,
        totalCount: 5,
        status: AbsenceStatus.rejected,
        documentType: DocumentType.none,
      ),
      AbsenceItem(
        id: '3',
        title: l10n.computerNetworks,
        date: DateTime(2026, 12, 5),
        currentCount: 4,
        totalCount: 5,
        status: AbsenceStatus.pending,
        documentType: DocumentType.none,
      ),
      AbsenceItem(
        id: '4',
        title: l10n.artificialIntelligence,
        date: DateTime(2027, 1, 20),
        currentCount: 3,
        totalCount: 5,
        status: AbsenceStatus.justified,
        documentType: DocumentType.pdf,
        documentName: 'JUST_20488.pdf',
      ),
    ];

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
