class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final String? eventId; // Optional reference to related event

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.eventId,
  });

  Notification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    String? eventId,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      eventId: eventId ?? this.eventId,
    );
  }
}

enum NotificationType {
  eventReminder,
  eventUpdate,
  eventCancellation,
  newEvent,
  general,
}

extension NotificationTypeExtension on NotificationType {
  String get displayName {
    switch (this) {
      case NotificationType.eventReminder:
        return 'Event Reminder';
      case NotificationType.eventUpdate:
        return 'Event Update';
      case NotificationType.eventCancellation:
        return 'Event Cancellation';
      case NotificationType.newEvent:
        return 'New Event';
      case NotificationType.general:
        return 'General';
    }
  }
} 