import 'package:flutter/material.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:minimart/utils/data.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  void _markAllRead() {
    setState(() {
      for (var n in notifications) {
        n["isRead"] = true;
      }
    });
  }

  void _clearAll() {
    setState(() {
      notifications.clear();
    });
  }

  IconData _iconForType(String type) {
    switch (type) {
      case "purchase":
        return FontAwesomeIcons.bagShopping;
      case "coupon":
        return FontAwesomeIcons.tag;
      default:
        return FontAwesomeIcons.circleInfo;
    }
  }

  Color _colorForType(String type) {
    switch (type) {
      case "purchase":
        return primaryColor;
      case "coupon":
        return accentColor;
      default:
        return Colors.blueAccent;
    }
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return DateFormat("MMM d, h:mm a").format(dt);
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
                return _NotifCard(
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
                  iconData: _iconForType(notif["type"]),
                  accentClr: _colorForType(notif["type"]),
                  timeLabel: _formatTime(notif["time"]),
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

// ── Individual Notification Card ────────────────────────────────────────────
class _NotifCard extends StatelessWidget {
  const _NotifCard({
    required this.notif,
    required this.onTap,
    required this.onDismiss,
    required this.iconData,
    required this.accentClr,
    required this.timeLabel,
  });

  final Map<String, dynamic> notif;
  final VoidCallback onTap;
  final VoidCallback onDismiss;
  final IconData iconData;
  final Color accentClr;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final bool isRead = notif["isRead"] == true;

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: errorColor.withOpacity(0.85),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 24),
      ),
      onDismissed: (_) => onDismiss(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isRead ? surfaceColor : surfaceColor.withOpacity(0.95),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isRead
                  ? primaryColor.withOpacity(0.08)
                  : accentClr.withOpacity(0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentClr.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: accentClr.withOpacity(0.3), width: 1),
                ),
                child:
                    Center(child: FaIcon(iconData, color: accentClr, size: 16)),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notif["title"],
                          style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight:
                                  isRead ? FontWeight.w500 : FontWeight.bold),
                        ),
                        Text(
                          timeLabel,
                          style: TextStyle(color: subTextColor, fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif["message"],
                      style: TextStyle(
                          color: subTextColor, fontSize: 12, height: 1.4),
                    ),
                  ],
                ),
              ),
              // Unread dot
              if (!isRead)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(color: accentClr, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}








