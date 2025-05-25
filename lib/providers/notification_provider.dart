import 'package:flutter/foundation.dart';
import '../models/notification.dart' as app_notification;

class NotificationProvider extends ChangeNotifier {
  List<app_notification.Notification> _notifications = [
    app_notification.Notification(
      id: '1',
      title: 'Event Reminder',
      message: 'Tech Summit 2024 starts in 2 hours. Don\'t forget to attend!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      type: app_notification.NotificationType.eventReminder,
      isRead: false,
      eventId: 'tech-summit-2024',
    ),
    app_notification.Notification(
      id: '2',
      title: 'New Event Available',
      message: 'Spring Festival 2024 registration is now open. Register now!',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: app_notification.NotificationType.newEvent,
      isRead: false,
    ),
    app_notification.Notification(
      id: '3',
      title: 'Event Update',
      message: 'Job Fair venue has been changed to Main Auditorium.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: app_notification.NotificationType.eventUpdate,
      isRead: true,
      eventId: 'job-fair-2024',
    ),
    app_notification.Notification(
      id: '4',
      title: 'Welcome to UniEventz',
      message: 'Thank you for joining UniEventz! Discover amazing events happening around your campus.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: app_notification.NotificationType.general,
      isRead: true,
    ),
    app_notification.Notification(
      id: '5',
      title: 'Event Cancelled',
      message: 'Unfortunately, the Music Concert has been cancelled due to weather conditions.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      type: app_notification.NotificationType.eventCancellation,
      isRead: true,
    ),
  ];

  List<app_notification.Notification> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  void addNotification(app_notification.Notification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void clearAllNotifications() {
    _notifications.clear();
    notifyListeners();
  }
} 