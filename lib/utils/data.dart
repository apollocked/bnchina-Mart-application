export 'data/product_data.dart';
export 'data/user_data.dart';

Map<String, dynamic> currentUser = {
  "username": "apollo",
  "email": "apollo@",
  "password": "aaaaaaaa",
  "discount": 0,
};
List<Map<String, dynamic>> orders = [];

// ── Notifications ─────────────────────────────────────────────────────────
List<Map<String, dynamic>> notifications = [];

void addNotification({
  required String title,
  required String message,
  required String type, // "purchase" | "coupon" | "info"
}) {
  notifications.insert(0, {
    "title": title,
    "message": message,
    "type": type,
    "time": DateTime.now(),
    "isRead": false,
  });
}

List<Map<String, dynamic>> basketItems = [];
