import 'package:abs/core/entities/module_stats.dart';
import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:abs/features/absences/widgets/check_absences_card.dart';
import 'package:abs/features/absences/widgets/content_sheet.dart';
import 'package:abs/features/absences/widgets/overall_score_card.dart';
import 'package:abs/features/absences/widgets/page_header.dart';
import 'package:abs/features/absences/widgets/semester_tab.dart';
import 'package:abs/features/absences/widgets/subject_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModulesAttendanceScreen extends StatefulWidget {
  const ModulesAttendanceScreen({super.key});

  @override
  State<ModulesAttendanceScreen> createState() =>
      _ModulesAttendanceScreenState();
}

class _ModulesAttendanceScreenState extends State<ModulesAttendanceScreen> {
  int _selectedSemester = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 64),
          PageHeader(
            title: l10n.attendanceTitle,
            subtitle: l10n.attendanceSubtitle,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ContentSheet(
              children: [
                const SizedBox(height: 24),
                CheckAbsencesCard(
                  title: l10n.checkAbsencesTitle,
                  actionLabel: l10n.checkAbsencesAction,
                ),
                const SizedBox(height: 8),
                BlocBuilder<MyAbsenceCubit, MyAbsenceState>(
                  builder: (context, state) {
                    if (state is MyAbsenceSuccess) {
                      final List<ModuleStats> subjects = state.modulesStats;
                      return Column(
                        children: [
                          OverallScoreCard(
                            label: l10n.overallScoreLabel,
                            group: l10n.overallScoreGroup,
                            percentage: state.attendanceRate.round(),
                          ),
                          const SizedBox(height: 12),
                          SemesterTab(
                            label1: l10n.semester1,
                            label2: l10n.semester2,
                            selectedIndex: _selectedSemester,
                            onChanged: (index) =>
                                setState(() => _selectedSemester = index),
                          ),
                        const SizedBox(height: 8),
                          ...subjects.map(
                            (subject) => SubjectCard(
                              title: subject.moduleName,
                              subtitle:
                                  '${subject.totalSessions - subject.absences}/${subject.totalSessions}',
                              percentage: subject.getAttendanceRate,
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is MyAbsenceError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),

                const SizedBox(height: 128),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
