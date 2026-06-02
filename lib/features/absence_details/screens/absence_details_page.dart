import 'package:abs/config/constants/enums.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/absence_details/widgets/absence_info_card.dart';
import 'package:abs/features/absence_details/widgets/page_header.dart';
import 'package:abs/features/absence_details/widgets/rejection_alert_card.dart';
import 'package:abs/features/absence_details/widgets/upload_justification_button.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AbsenceDetailsPage extends StatelessWidget {
  const AbsenceDetailsPage({super.key, required this.absence});

  final AbsenceEntity absence;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          PageHeader(
            title: l10n.absenceDetailsTitle,
            subtitle: l10n.trackManageAbsences,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  AbsenceInfoCard(absence: absence),
                  const SizedBox(height: 24),
                  if (absence.justificationStatus == AbsenceStatus.rejected)
                    const RejectionAlertCard(),
                  const SizedBox(height: 24),
                  if (absence.justificationStatus == AbsenceStatus.pending ||
                      absence.justificationStatus ==
                          AbsenceStatus.unjustified ||
                      absence.justificationStatus == AbsenceStatus.rejected)
                    UploadJustificationButton(absence: absence),
                  const SizedBox(height: 62),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
