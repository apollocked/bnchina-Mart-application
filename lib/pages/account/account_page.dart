import 'dart:io';
import 'package:minimart/pages/account/account_sub_pages/edit_account_page.dart';
import 'package:minimart/pages/account/account_sub_pages/discount_page.dart';
import 'package:minimart/pages/account/account_sub_pages/notifications_page.dart';
import 'package:minimart/pages/account/account_sub_pages/orders_page.dart';
import 'package:minimart/pages/account/account_sub_pages/signout_message.dart';
import 'package:minimart/pages/account/account_sub_pages/delete_account_dialog.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/widgets/item_lists/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({super.key});

  @override
  State<Accountpage> createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
  Future<void> _refreshUserData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() {});
  }

  ImageProvider? _getProfileImage() {
    final user = UserService().currentUser;
    final path = user["profileImagePath"];
    final isCustom = user["isCustomImage"] ?? false;

    if (path == null || path.isEmpty) {
      return null;
    }

    if (isCustom) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshUserData(context),
      color: primaryColor,
      backgroundColor: surfaceColor,
      child: ListView(
        children: [
          const SizedBox(height: 10),

          // ── Profile Header Card ─────────────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff0A2436), Color(0xff1A3B45)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: primaryColor.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar with glow ring
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: _getProfileImage(),
                    radius: 40,
                    backgroundColor: surfaceColor,
                    child: _getProfileImage() == null
                        ? Icon(Icons.person, size: 45, color: primaryColor)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                // Name + email
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserService().currentUser["username"]?.toString() ??
                                "Guest",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          if (UserService().currentUser["email"] != null)
                            Text(
                              UserService().currentUser["email"],
                              style: TextStyle(
                                color: subTextColor,
                                fontSize: 13,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Premium Member",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditAccountPage(),
                            ),
                          );
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          Icons.edit_rounded,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Menu Tiles ──────────────────────────────────────────────────
          CustomTile(
              text: "My Orders",
              icon: SvgPicture.asset(basketIcon, color: primaryColor),
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrdersPage()));
              }),
          CustomTile(
            text: "Notifications",
            icon: SvgPicture.asset(notificationIcon, color: primaryColor),
            ontap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()),
              );
              // Rebuild badge after returning from notifications page
              setState(() {});
            },
          ),
          CustomTile(
            text: "Coupons & Discounts",
            icon: SvgPicture.asset(starIcon, color: primaryColor),
            ontap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: surfaceColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  context: context,
                  builder: (context) {
                    return const DiscountPage();
                  });
            },
          ),
          CustomTile(
            text: "Sign Out",
            icon: SvgPicture.asset(signoutIcon, color: errorColor),
            ontap: () {
              showDialog(
                  context: context,
                  builder: (context) => const SignoutMessage());
            },
          ),
          CustomTile(
            text: "Delete Account",
            icon: Icon(Icons.delete_outline, color: errorColor),
            ontap: () {
              showDialog(
                  context: context,
                  builder: (context) => const DeleteAccountDialog());
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
