import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionSelector extends StatelessWidget {
  const SessionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.missedSessionsLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: inputDecoration,
          hint: Text(l10n.selectPlaceholder),
          items: const [
            DropdownMenuItem(
              value: 'session1',
              child: Text('BDD - Oct 24, 09:00'),
            ),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: inputDecoration,
          items: const [
            DropdownMenuItem(
              value: 'session2',
              child: Text('BDD - Oct 24, 09:00'),
            ),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
