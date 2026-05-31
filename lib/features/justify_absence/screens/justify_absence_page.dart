import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/absences/widgets/page_header.dart';
import 'package:abs/features/justify_absence/widgets/comments_input.dart';
import 'package:abs/features/justify_absence/widgets/document_uploader.dart';
import 'package:abs/features/justify_absence/widgets/reason_selector.dart';
import 'package:abs/features/justify_absence/widgets/session_selector.dart';
import 'package:abs/features/justify_absence/widgets/submit_button.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class JustifyAbsencePage extends StatelessWidget {
  const JustifyAbsencePage({super.key, required this.absence});

  final AbsenceItem absence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 128, 16, 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: PageHeader(
                title: l10n.justifyAbsenceTitle,
                subtitle: l10n.justifyAbsenceSubtitle,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  SessionSelector(),
                  SizedBox(height: 24),
                  ReasonSelector(),
                  SizedBox(height: 24),
                  DocumentUploader(),
                  SizedBox(height: 24),
                  CommentsInput(),
                  SizedBox(height: 24),
                  SubmitButton(),
                ],
              ),
            ),

            SizedBox(height: 62),
          ],
        ),
      ),
    );
  }
}
