import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:abs/features/absences/widgets/absence_list.dart';
import 'package:abs/features/absences/widgets/absences_header.dart';
import 'package:abs/features/absences/widgets/filter_tabs.dart';
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
            // TotalAbsencesCard(
            //   title: l10n.totalAbsences,
            //   subtitle: l10n.semester1,
            //   percentage: 0.7,
            // ),
            SizedBox(height: 16),
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
                  if (state.absences.isEmpty) {
                    return Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.only(top: 120),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              l10n.noAbsences,
                              style: AppTextStyles.h1.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
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
