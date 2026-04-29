import 'package:abs/features/attendance/widgets/page_header.dart';
import 'package:abs/features/justify_absence/widgets/empty_exams_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ExamSchedulePage extends StatelessWidget {
  const ExamSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 128, 16, 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),

            child: PageHeader(
              title: l10n.examScheduleTitle,
              subtitle: l10n.examScheduleSubtitle,
            ),
          ),
          SizedBox(height: 24),

          EmptyExamsCard(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
