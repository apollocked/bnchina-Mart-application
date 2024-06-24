import 'package:MiniMart/pages/Account_page/Account_Page_Listtile_pages/change_password_page.dart';
import 'package:MiniMart/pages/Account_page/Account_Page_Listtile_pages/discount_page.dart';
import 'package:MiniMart/pages/Account_page/Account_Page_Listtile_pages/orders_page.dart';
import 'package:MiniMart/pages/Authotication/register_page.dart';
import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_list_tile.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_snackBar.dart';
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
              const SizedBox(
                height: 10,
              ),
              Text(
                currentUser["username"] ?? "MiniMart",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        CustomTile(
            text: "Orders",
            icon: SvgPicture.asset(
              basketIcon,
              color: primaryColor,
            ),
            ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OrdersPage();
              }));
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
              currentUser = {};
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUpPage();
              }));
            }),
      ],
    );
  }
}
