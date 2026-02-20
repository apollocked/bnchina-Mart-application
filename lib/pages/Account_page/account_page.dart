import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/change_password_page.dart';
import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/discount_page.dart';
import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/orders_page.dart';
import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/signout_massege.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Item_Lests/custom_list_tile.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  Future<void> _refreshUserData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
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
            padding: const EdgeInsets.all(20),
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
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(avatarBoy),
                    radius: 40,
                  ),
                ),
                const SizedBox(width: 16),
                // Name + email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser["username"]?.toString() ?? "Guest",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      if (currentUser["email"] != null)
                        Text(
                          currentUser["email"],
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
              text: "Change Password",
              icon: Icon(Icons.lock_outline_rounded, color: primaryColor),
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ChangePasswordPage();
                }));
              }),
          CustomTile(
            text: "Notifications",
            icon: SvgPicture.asset(notificationIcon, color: primaryColor),
            ontap: () {
              CustomSnackbar(
                  errorColor, context, "We're still working on this 🚧");
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
                  context: context, builder: (context) => SignoutMassege());
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
