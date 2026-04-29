import 'package:abs/features/justify_absence/widgets/comments_input.dart';
import 'package:abs/features/justify_absence/widgets/document_uploader.dart';
import 'package:abs/features/justify_absence/widgets/reason_selector.dart';
import 'package:abs/features/justify_absence/widgets/session_selector.dart';
import 'package:abs/features/justify_absence/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class JustificationFormCard extends StatelessWidget {
  const JustificationFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
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
    );
  }
}
