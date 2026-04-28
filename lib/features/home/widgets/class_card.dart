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

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.menu_book),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  Text(teacher, style: theme.textTheme.titleMedium),
                  Text(room, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),

            Column(
              children: [
                Text(time),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    //TODO: Navigate to scanner page
                  },
                  child: Text(l10n.scanQrCode),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
