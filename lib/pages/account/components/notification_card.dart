import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:minimart/utils/colors.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notif;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCard({
    super.key,
    required this.notif,
    required this.onTap,
    required this.onDismiss,
  });

  static IconData iconForType(String type) {
    switch (type) {
      case "purchase":
        return FontAwesomeIcons.bagShopping;
      case "coupon":
        return FontAwesomeIcons.tag;
      default:
        return FontAwesomeIcons.circleInfo;
    }
  }

  static Color colorForType(String type) {
    switch (type) {
      case "purchase":
        return primaryColor;
      case "coupon":
        return accentColor;
      default:
        return Colors.blueAccent;
    }
  }

  static String formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return DateFormat("MMM d, h:mm a").format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final bool isRead = notif["isRead"] == true;
    final String type = notif["type"] ?? "info";
    final IconData iconData = iconForType(type);
    final Color accentClr = colorForType(type);
    final String timeLabel = formatTime(notif["time"] ?? DateTime.now());

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
