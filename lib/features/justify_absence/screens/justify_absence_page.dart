import 'package:abs/features/attendance/widgets/page_header.dart';
import 'package:abs/features/justify_absence/widgets/justification_form_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class JustifyAbsencePage extends StatelessWidget {
  const JustifyAbsencePage({super.key});

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

            JustificationFormCard(),

            SizedBox(height: 62),
          ],
        ),
      ),
    );
  }
}
