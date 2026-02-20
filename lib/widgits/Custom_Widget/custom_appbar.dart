import 'package:minimart/pages/notifications_page.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
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
  int get _unreadCount =>
      notifications.where((n) => n["isRead"] == false).length;

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
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationsPage()),
            );
            // Rebuild badge after returning from notifications page
            setState(() {});
          },
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
              clipBehavior: Clip.none,
              children: [
                FaIcon(
                  FontAwesomeIcons.bell,
                  color: primaryColor,
                  size: 16,
                ),
                if (_unreadCount > 0)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: errorColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: backgroundColor, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          _unreadCount > 9 ? "9+" : "$_unreadCount",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                        ),
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
