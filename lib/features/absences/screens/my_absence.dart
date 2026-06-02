import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:abs/features/absences/widgets/absence_list.dart';
import 'package:abs/features/absences/widgets/absences_header.dart';
import 'package:abs/features/absences/widgets/filter_tabs.dart';
import 'package:abs/features/absences/widgets/total_absences_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAbsenceScreen extends StatelessWidget {
  const MyAbsenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

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
                l10n.filterAll,
                l10n.filterPending,
                l10n.filterApproved,
                l10n.filterRejected,
                l10n.filterJustified,
              ],
            ),
            BlocBuilder<MyAbsenceCubit, MyAbsenceState>(
              builder: (context, state) {
                if (state is MyAbsenceSuccess) {
                  return AbsenceList(absences: state.absences);
                }
                if (state is MyAbsenceError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),

            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
