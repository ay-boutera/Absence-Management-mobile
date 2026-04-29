import 'package:abs/core/entities/subject_attendance_entity.dart';
import 'package:abs/features/attendance/widgets/check_absences_card.dart';
import 'package:abs/features/attendance/widgets/content_sheet.dart';
import 'package:abs/features/attendance/widgets/overall_score_card.dart';
import 'package:abs/features/attendance/widgets/page_header.dart';
import 'package:abs/features/attendance/widgets/semester_tab.dart';
import 'package:abs/features/attendance/widgets/subject_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ManualAttendanceScreen extends StatefulWidget {
  const ManualAttendanceScreen({super.key});

  @override
  State<ManualAttendanceScreen> createState() => _ManualAttendanceScreenState();
}

class _ManualAttendanceScreenState extends State<ManualAttendanceScreen> {
  int _selectedSemester = 0;

  List<SubjectAttendanceEntity> _subjectsForSemester(
    AppLocalizations l10n,
    int semester,
  ) {
    if (semester == 0) {
      return [
        SubjectAttendanceEntity(
          title: l10n.subjectLow,
          sessions: 5,
          percentage: 70,
        ),
        SubjectAttendanceEntity(
          title: l10n.subjectAcsi,
          sessions: 3,
          percentage: 40,
        ),
        SubjectAttendanceEntity(
          title: l10n.subjectBdd,
          sessions: 2,
          percentage: 25,
        ),
        SubjectAttendanceEntity(
          title: l10n.subjectTdd,
          sessions: 3,
          percentage: 55,
        ),
        SubjectAttendanceEntity(
          title: l10n.subjectCiCd,
          sessions: 0,
          percentage: 85,
          subtitle: l10n.priorityHigh,
        ),
      ];
    }

    // Semester 2 – placeholder data
    return [
      SubjectAttendanceEntity(
        title: l10n.subjectLow,
        sessions: 8,
        percentage: 90,
      ),
      SubjectAttendanceEntity(
        title: l10n.subjectAcsi,
        sessions: 6,
        percentage: 60,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final subjects = _subjectsForSemester(l10n, _selectedSemester);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: l10n.attendanceTitle,
              subtitle: l10n.attendanceSubtitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ContentSheet(
                children: [
                  const SizedBox(height: 20),
                  CheckAbsencesCard(
                    title: l10n.checkAbsencesTitle,
                    actionLabel: l10n.checkAbsencesAction,
                  ),
                  const SizedBox(height: 8),
                  OverallScoreCard(
                    label: l10n.overallScoreLabel,
                    group: l10n.overallScoreGroup,
                    percentage: 85,
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
                      title: subject.title,
                      subtitle: subject.getFactor(),
                      percentage: subject.percentage,
                    ),
                  ),
                  const SizedBox(height: 128),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
