import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/change_password_page.dart';
import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/discount_page.dart';
import 'package:minimart/pages/Account_page/Account_Page_Listtile_pages/orders_page.dart';
import 'package:minimart/pages/Authotication/register_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Item_Lests/custom_list_tile.dart';
import 'package:minimart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(avatarBoy),
                radius: 50,
              ),
              const SizedBox(height: 10),
              Text(
                currentUser["username"]?.toString() ?? "Guest",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
              if (currentUser["email"] != null)
                Text(
                  currentUser["email"],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomTile(
            text: "Orders",
            icon: SvgPicture.asset(
              basketIcon,
              color: primaryColor,
            ),
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrdersPage()));
            }),
        CustomTile(
            text: "Change password",
            icon: Icon(
              Icons.password_sharp,
              color: primaryColor,
            ),
            ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ChangePasswordPage();
              }));
            }),
        CustomTile(
          text: "Notfications",
          icon: SvgPicture.asset(
            notificationIcon,
            color: primaryColor,
          ),
          ontap: () {
            CustomSnackbar(errorColor, context, "we still are working on it");
          },
        ),
        CustomTile(
          text: "Coupons",
          icon: SvgPicture.asset(starIcon, color: primaryColor),
          ontap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: backgroundColor,
                context: context,
                builder: (context) {
                  return const DiscountPage();
                });
          },
        ),
        CustomTile(
          text: "Signout",
          icon: SvgPicture.asset(
            signoutIcon,
            color: primaryColor,
          ),
          ontap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Sign Out"),
                content: Text("Are you sure you want to sign out?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      currentUser = {};
                      Navigator.pop(context); // Close dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child:
                        Text("Sign Out", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
