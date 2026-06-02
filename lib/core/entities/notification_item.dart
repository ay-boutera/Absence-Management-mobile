import 'package:abs/config/constants/enums.dart';

class NotificationItem {
  final String id;
  final NotificationType? type;
  final String title;
  final String body;
  final String? justificationId;
  final String? moduleName;
  final bool isRead;
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    this.type,
    required this.title,
    required this.body,
    this.justificationId,
    this.moduleName,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    NotificationType? type;
    if (json['type'] != null) {
      try {
        type = NotificationType.values.firstWhere((e) => e.name == json['type']);
      } catch (_) {
        type = null;
      }
    }

    return NotificationItem(
      id: json['id'] ?? '',
      type: type,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      justificationId: json['justification_id'],
      moduleName: json['module_name'],
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }
}
