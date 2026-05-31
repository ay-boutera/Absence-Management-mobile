import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ReasonSelector extends StatefulWidget {
  // 1. Add the callback parameter here
  const ReasonSelector({super.key, required this.onChanged});

  final ValueChanged<String?> onChanged;

  @override
  State<ReasonSelector> createState() => _ReasonSelectorState();
}

class _ReasonSelectorState extends State<ReasonSelector> {
  String _selectedValue = 'sick';

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
          initialValue: _selectedValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(12),
          dropdownColor: theme.colorScheme.surfaceContainerHigh,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          elevation: 4,

          items: [
            DropdownMenuItem(value: 'sick', child: Text(l10n.sickOption)),
            DropdownMenuItem(
              value: 'family_emergency',
              child: Text(l10n.familyEmergency),
            ),
            DropdownMenuItem(value: 'other', child: Text(l10n.other)),
          ],
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _selectedValue = newValue;
              });
              // 2. Notify the parent page about the new reason value
              widget.onChanged(newValue);
            }
          },
        ),
      ],
    );
  }
}
