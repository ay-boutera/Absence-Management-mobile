import 'package:abs/config/constants/enums.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/notification_item.dart';
import 'package:abs/features/notifications/widgets/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Mock static data populating the list view perfectly matches your reference image hierarchy
  final List<NotificationItem> _mockNotifications = const [
    NotificationItem(
      type: NotificationType.attendanceRecorded,
      titleKey: 'attendanceRecorded',
      descriptionKey: 'attendanceRecordedDesc',
      timeAgo: '2m ago',
      hasUnreadDot: true,
    ),
    NotificationItem(
      type: NotificationType.markedAbsent,
      titleKey: 'markedAbsent',
      descriptionKey: 'markedAbsentDesc',
      timeAgo: '2m ago',
      hasUnreadDot: true,
    ),
    NotificationItem(
      type: NotificationType.justificationSubmitted,
      titleKey: 'justificationSubmitted',
      descriptionKey: 'justificationSubmittedDesc',
      timeAgo: '2m ago',
      hasUnreadDot: true,
    ),
    NotificationItem(
      type: NotificationType.justificationApproved,
      titleKey: 'justificationApproved',
      descriptionKey: 'justificationApprovedDesc',
      timeAgo: '2m ago',
    ),
    NotificationItem(
      type: NotificationType.justificationRejected,
      titleKey: 'justificationRejected',
      descriptionKey: 'justificationRejectedDesc',
      timeAgo: '2m ago',
    ),
    NotificationItem(
      type: NotificationType.classCancelled,
      titleKey: 'classCancelled',
      descriptionKey: 'classCancelledDesc',
      timeAgo: '2m ago',
    ),
    NotificationItem(
      type: NotificationType.scheduleUpdated,
      titleKey: 'scheduleUpdated',
      descriptionKey: 'scheduleUpdatedDesc',
      timeAgo: '2m ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final localizations = AppLocalizations.of(context)!;
    final colorsheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorsheme.surface, // Crisp off-white background canvas
      body: Column(
        children: [
          // Custom Header Container Block
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 64,
              left: 24,
              right: 24,
              bottom: 28,
            ),
            decoration: BoxDecoration(
              color: colorsheme
                  .primary, // Matches global setup or choice dark navy blue color block
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications", // Update to localizations.notificationsScreenTitle later
                  style: AppTextStyles.heading1.copyWith(
                    color: colorsheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Check your notifications", // Update to localizations.notificationsScreenSubtitle later
                  style: AppTextStyles.body1.copyWith(
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          // Scrollassssble Dynamic Notifications Stream List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              itemCount: _mockNotifications.length,
              itemBuilder: (context, index) {
                final notification = _mockNotifications[index];
                return NotificationCard(
                  item: notification,
                  onPrimaryActionPressed: () {
                    // Logic linked here later
                  },
                  onSecondaryActionPressed: () {
                    // Logic linked here later
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
