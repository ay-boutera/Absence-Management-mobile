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

  final AbsenceEntity absence;

  @override
  State<JustifyAbsencePage> createState() => _JustifyAbsencePageState();
}

class _JustifyAbsencePageState extends State<JustifyAbsencePage> {
  // ignore: unused_field
  String _selectedReason = 'sick';
  String? _uploadedDocumentPath;
  // ignore: unused_field
  String _comment = '';

  // Local state for loading indication
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
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
      reason: _comment,
      absenceId: widget.absence.absenceId,
      documentPath: _uploadedDocumentPath!,
      // sessionId: widget.absence.sessionId,
    );

    // Start loading state
    setState(() {
      _isSubmitting = true;
    });

    try {
      // TODO: Call your repository or API service here instead of the Cubit
      // await myRepository.submitJustification(justificationPayload, widget.absence.absenceId);

      // Simulating a network delay for demonstration
      await context.read<MyAbsenceCubit>().submitJustification(
        justificationPayload,
        widget.absence.absenceId,
      );

      // Ensure widget is still in the tree before using context
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Justification uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop(); // Go back on clean success response
    } catch (e) {
      // Ensure widget is still in the tree before using context
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ), // Replace with a user-friendly error message if needed
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      // Stop loading state
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
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
                    isLoading: _isSubmitting,
                    onPressed: _handleSubmit,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 62),
          ],
        ),
      ),
    );
  }
}
