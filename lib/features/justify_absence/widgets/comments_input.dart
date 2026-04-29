import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CommentsInput extends StatelessWidget {
  const CommentsInput({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.additionalCommentsLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: l10n.commentsPlaceholder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.all(16),
            filled: true,
            fillColor: theme.colorScheme.surface.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }
}
