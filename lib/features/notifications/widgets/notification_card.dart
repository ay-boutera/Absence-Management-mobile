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
        color: item.isRead
            ? theme.surface
            : theme.surfaceContainerHighest.withAlpha(100),
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
                          item.title,
                          style: AppTextStyles.h3.copyWith(
                            color: theme.onSurface,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      _getTimeAgo(item.createdAt),
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
                    item.body,
                    style: AppTextStyles.body1.copyWith(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!item.isRead)
            Positioned(
              left: 12,
              top: 24,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}
