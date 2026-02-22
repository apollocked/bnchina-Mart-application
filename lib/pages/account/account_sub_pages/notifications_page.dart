import 'package:flutter/material.dart';
import 'package:minimart/pages/account/components/notification_card.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  void _markAllRead() {
    setState(() {
      NotificationService().markAllRead();
    });
  }

  void _clearAll() {
    setState(() {
      NotificationService().clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = NotificationService().unreadCount;
    final notifications = NotificationService().notifications;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: textColor, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"),
            ),
            if (unreadCount > 0)
              Text(
                "$unreadCount unread",
                style: TextStyle(
                    color: primaryColor, fontSize: 11, fontFamily: "Poppins"),
              ),
          ],
        ),
        actions: [
          if (notifications.isNotEmpty)
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert_rounded, color: subTextColor),
              color: surfaceColor,
              onSelected: (value) {
                if (value == "read_all") _markAllRead();
                if (value == "clear_all") _clearAll();
              },
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  value: "read_all",
                  child: Row(
                    children: [
                      Icon(Icons.done_all_rounded,
                          color: primaryColor, size: 18),
                      const SizedBox(width: 8),
                      Text("Mark all as read",
                          style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "clear_all",
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep_rounded,
                          color: errorColor, size: 18),
                      const SizedBox(width: 8),
                      Text("Clear all", style: TextStyle(color: errorColor)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return NotificationCard(
                  notif: notif,
                  onTap: () {
                    setState(() {
                      NotificationService().markAsRead(index);
                    });
                  },
                  onDismiss: () {
                    setState(() {
                      NotificationService().removeNotification(index);
                    });
                  },
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: surfaceColor,
              shape: BoxShape.circle,
              border:
                  Border.all(color: primaryColor.withOpacity(0.2), width: 1),
            ),
            child: FaIcon(FontAwesomeIcons.bell, color: subTextColor, size: 38),
          ),
          const SizedBox(height: 20),
          Text(
            "No notifications yet",
            style: TextStyle(
                color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            "Your purchase and coupon alerts\nwill appear here",
            textAlign: TextAlign.center,
            style: TextStyle(color: subTextColor, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}
