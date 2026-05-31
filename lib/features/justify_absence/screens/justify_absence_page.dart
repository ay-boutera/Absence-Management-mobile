import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/core/entities/justification.dart';
import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:abs/features/absences/widgets/page_header.dart';
import 'package:abs/features/justify_absence/widgets/comments_input.dart';
import 'package:abs/features/justify_absence/widgets/document_uploader.dart';
import 'package:abs/features/justify_absence/widgets/reason_selector.dart';
import 'package:abs/features/justify_absence/widgets/session_selector.dart';
import 'package:abs/features/justify_absence/widgets/submit_button.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JustifyAbsencePage extends StatefulWidget {
  const JustifyAbsencePage({super.key, required this.absence});

  final AbsenceItem absence;

  @override
  State<JustifyAbsencePage> createState() => _JustifyAbsencePageState();
}

class _JustifyAbsencePageState extends State<JustifyAbsencePage> {
  String _selectedReason = 'sick';
  String? _uploadedDocumentPath;
  // ignore: unused_field
  String _comment = '';

  void _handleSubmit() {
    if (_uploadedDocumentPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an evidence document first.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final justificationPayload = Justification(
      scopeType: 'absence',
      reason: _selectedReason,
      absenceId: widget.absence.absenceId,
      documentPath: _uploadedDocumentPath!,
      sessionId: widget.absence.sessionId,
    );

    context.read<MyAbsenceCubit>().submitJustification(justificationPayload);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<MyAbsenceCubit, MyAbsenceState>(
        listener: (context, state) {
          if (state is MyAbsenceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Justification uploaded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop(); // Go back on clean success response
          } else if (state is MyAbsenceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          // Check if global cubit layer is currently talking to the network
          final isSubmitting = state is MyAbsenceLoading;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 128, 16, 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
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
                    children: [
                      SessionSelector(absence: widget.absence),
                      const SizedBox(height: 24),

                      // Pass down callback to collect selected dropdown options
                      ReasonSelector(
                        onChanged: (reason) {
                          setState(() => _selectedReason = reason ?? 'sick');
                        },
                      ),
                      const SizedBox(height: 24),

                      // Pass down callback to collect picked file location paths
                      DocumentUploader(
                        onFilePicked: (path) {
                          setState(() => _uploadedDocumentPath = path);
                        },
                      ),
                      const SizedBox(height: 24),
                      CommentsInput(
                        onChanged: (value) {
                          setState(() => _comment = value);
                        },
                      ),
                      const SizedBox(height: 24),

                      SubmitButton(
                        isLoading: isSubmitting,
                        onPressed: _handleSubmit,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 62),
              ],
            ),
          );
        },
      ),
    );
  }
}
