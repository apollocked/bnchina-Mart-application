import 'package:minimart/pages/account/account_sub_pages/notifications_page.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Convert to a PreferredSizeWidget so we can rebuild for the badge count
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // Badge updates are handled purely by rebuilding when NotificationService state changes
  // or when navigating back from NotificationsPage, since we use `setState`

  void _navigateToNotifications() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationsPage()),
    );
    // Refresh the UI to reflect new notification count
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Location",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: subTextColor),
          ),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.locationDot,
                color: primaryColor,
                size: 13,
              ),
              const SizedBox(width: 5),
              Text("Erbil, Iraq",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor)),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: _navigateToNotifications,
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                FaIcon(
                  FontAwesomeIcons.bell,
                  color: primaryColor,
                  size: 20,
                ),

                // Unread badge logic using NotificationService
                if (NotificationService().unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: errorColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: surfaceColor, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Keep backward-compat function for callers still using customAppBar()
PreferredSizeWidget customAppBar() => const CustomAppBar();








