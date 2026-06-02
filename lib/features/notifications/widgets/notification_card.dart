import 'package:abs/config/constants/enums.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback? onPrimaryActionPressed;
  final VoidCallback? onSecondaryActionPressed;

  const NotificationCard({
    super.key,
    required this.item,
    this.onPrimaryActionPressed,
    this.onSecondaryActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.primary.withAlpha(30), width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.primary.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row: Icon + Title + Timestamp
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),

                    // Localization keys mapped directly
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          _getLocalizedTitle(context, item.type),
                          style: AppTextStyles.h3.copyWith(
                            color: theme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      item.timeAgo, // Kept static / relative string
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),

                // Description/Body Row
                Padding(
                  padding: const EdgeInsets.only(left: 48, top: 8, right: 8),
                  child: Text(
                    _getLocalizedDescription(context, item.type),
                    style: AppTextStyles.body1.copyWith(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedTitle(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.attendanceRecorded:
        return "Attendance recorded !"; // localizations.attendanceRecordedTitle
      case NotificationType.markedAbsent:
        return "Marked Absent !";
      case NotificationType.justificationSubmitted:
        return "Justification submitted";
      case NotificationType.justificationApproved:
        return "Justification approved";
      case NotificationType.justificationRejected:
        return "Justification rejected";
      case NotificationType.classCancelled:
        return "Class cancelled !";
      case NotificationType.scheduleUpdated:
        return "Schedule updated";
    }
  }

  String _getLocalizedDescription(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.attendanceRecorded:
        return "You have been marked present for BDD - Mr. Kazi (10:00 – 12:00)";
      case NotificationType.markedAbsent:
        return "You are not assigned to the session of BDD - Mr. Kazi (10:00 – 12:00)";
      case NotificationType.justificationSubmitted:
        return "Your document is under review.";
      case NotificationType.justificationApproved:
        return "Your absence for Algorithms has been validated.";
      case NotificationType.justificationRejected:
        return "Reason: Missing or invalid document.";
      case NotificationType.classCancelled:
        return "Your Networks session tomorrow at 14:00 has been cancelled.";
      case NotificationType.scheduleUpdated:
        return "Your Databases class has been moved to Tuesday at 10:00.";
    }
  }
}
