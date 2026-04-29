// features/home/pages/home_page.dart

import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final String title;
  final String teacher;
  final String room;
  final String time;

  const ClassCard({
    super.key,
    required this.title,
    required this.teacher,
    required this.room,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.1  ),
        ),
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.menu_book,
                          color: theme.colorScheme.primary,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(title, style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    teacher,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(room, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),

            Column(
              children: [
                Text(time),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    //TODO: Navigate to scanner page
                  },
                  child: Text(
                    l10n.scanQrCode,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
