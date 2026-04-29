import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ReasonSelector extends StatelessWidget {
  const ReasonSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.reasonLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          // value: 'sick',
          items: [
            DropdownMenuItem(value: 'sick', child: Text(l10n.sickOption)),
            DropdownMenuItem(value: 'family', child: Text('Family Emergency')),
            DropdownMenuItem(value: 'other', child: Text('Other')),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
