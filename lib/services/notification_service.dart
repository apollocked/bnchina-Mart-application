import 'package:minimart/services/storage_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final StorageService _storage = StorageService();
  final String _notifKey = 'user_notifications';

  List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => _notifications;

  int get unreadCount =>
      _notifications.where((n) => n["isRead"] == false).length;

  void init() {
    // Read from storage and parse the 'time' strings back to DateTime
    final List<Map<String, dynamic>> raw = _storage.getList(_notifKey);
    _notifications = raw.map((n) {
      // Re-parse the date string
      if (n["time"] is String) {
        n["time"] = DateTime.tryParse(n["time"]) ?? DateTime.now();
      }
      return n;
    }).toList();
  }

  void _save() {
    // Convert DateTime to string for JSON
    final List<Map<String, dynamic>> toSave = _notifications.map((n) {
      final copy = Map<String, dynamic>.from(n);
      if (copy["time"] is DateTime) {
        copy["time"] = (copy["time"] as DateTime).toIso8601String();
      }
      return copy;
    }).toList();

    _storage.saveList(_notifKey, toSave);
  }

  void addNotification({
    required String title,
    required String message,
    required String type, // "purchase" | "coupon" | "info"
  }) {
    _notifications.insert(0, {
      "title": title,
      "message": message,
      "type": type,
      "time": DateTime.now(),
      "isRead": false,
    });
    _save();
  }

  void markAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index]["isRead"] = true;
      _save();
    }
  }

  void markAllRead() {
    for (var n in _notifications) {
      n["isRead"] = true;
    }
    _save();
  }

  void removeNotification(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications.removeAt(index);
      _save();
    }
  }

  void clearAll() {
    _notifications.clear();
    _save();
  }
}
