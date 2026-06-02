import 'package:abs/config/constants/enums.dart';

class NotificationItem {
  final NotificationType type;
  final String titleKey;
  final String descriptionKey;
  final String timeAgo;
  final bool hasUnreadDot;

  const NotificationItem({
    required this.type,
    required this.titleKey,
    required this.descriptionKey,
    required this.timeAgo,
    this.hasUnreadDot = false,
  });
}
