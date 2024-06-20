import 'package:MiniMart/pages/Account_page/Account_Page_Listtile_pages/change_password_page.dart';
import 'package:MiniMart/pages/Account_page/Account_Page_Listtile_pages/discount_page.dart';
import 'package:MiniMart/pages/Authotication/register_page.dart';
import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_list_tile.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:flutter/material.dart';

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
            testname: "Orders",
            icon: Icon(
              Icons.airplane_ticket_rounded,
              color: primaryColor,
            ),
            ontap: () {
              CustomSnackbar(errorColor, context, "we still are working on it");
            }),
        CustomTile(
            testname: "Change password",
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
          testname: "Notfications",
          icon: Icon(
            Icons.notifications,
            color: primaryColor,
          ),
          ontap: () {
            CustomSnackbar(errorColor, context, "we still are working on it");
          },
        ),
        CustomTile(
          testname: "Discount",
          icon: Icon(
            Icons.local_offer,
            color: primaryColor,
          ),
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
            testname: "Signout",
            icon: Icon(
              Icons.exit_to_app,
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
