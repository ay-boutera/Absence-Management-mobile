import 'package:abs/config/constants/enums.dart';
import 'package:abs/config/router/app_routes.dart';
import 'package:abs/core/entities/Absence_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenceListItem extends StatelessWidget {
  final AbsenceItem absence;

  const AbsenceListItem({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');
    final statusColor = absence.getStatusColor(theme);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.absenceDetails);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildIcon(theme, statusColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        absence.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(absence.date),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${absence.currentCount}/${absence.totalCount}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ${absence.statusText}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                _buildActionWidget(context, theme, statusColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme, Color color) {
    IconData iconData;

    switch (absence.status) {
      case AbsenceStatus.unjustified:
        iconData = Icons.description_outlined;
        break;
      case AbsenceStatus.rejected:
        iconData = Icons.cancel_outlined;
        break;
      case AbsenceStatus.pending:
        iconData = Icons.schedule_outlined;
        break;
      case AbsenceStatus.justified:
        iconData = Icons.check_circle_outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: color, size: 20),
    );
  }

  Widget _buildActionWidget(
    BuildContext context,
    ThemeData theme,
    Color color,
  ) {
    if (absence.status == AbsenceStatus.unjustified) {
      return TextButton(
        onPressed: () {
          // Handle justify action
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Justify now >',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (absence.status == AbsenceStatus.rejected) {
      return TextButton(
        onPressed: () {
          // Handle see reason action
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'See Reason >',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (absence.status == AbsenceStatus.pending) {
      return TextButton(
        onPressed: () {
          // Handle review action
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Review >',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.amber[700],
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (absence.documentType == DocumentType.pdf) {
      return TextButton(
        onPressed: () {
          // Handle PDF download/view
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          absence.documentName ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.green[700],
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
