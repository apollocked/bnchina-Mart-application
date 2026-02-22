// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:minimart/pages/cart/basket_page.dart';
import 'package:minimart/pages/account/account_page.dart';
import 'package:minimart/pages/home/home_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

int slectedpage = 0;
List<Widget> pages = [
  const HomePage(),
  const BasketPage(),
  const Accountpage(),
];

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: pages[slectedpage]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: slectedpage,
            backgroundColor: surfaceColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: IconThemeData(color: primaryColor),
            selectedLabelStyle: TextStyle(
                color: primaryColor, fontWeight: FontWeight.bold, fontSize: 11),
            unselectedLabelStyle: TextStyle(color: subTextColor, fontSize: 11),
            selectedItemColor: primaryColor,
            unselectedItemColor: subTextColor,
            elevation: 0,
            onTap: (index) {
              setState(() {
                slectedpage = index;
              });
            },
            items: [
              // ignore: deprecated_member_use
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      homeIcon,
                      color: slectedpage == 0 ? primaryColor : subTextColor,
                      height: 22,
                    ),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      basketIcon,
                      // ignore: deprecated_member_use
                      color: slectedpage == 1 ? primaryColor : subTextColor,
                      height: 22,
                    ),
                  ),
                  label: "Basket"),
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: CircleAvatar(
                      maxRadius: 14,
                      backgroundImage: AssetImage(avatarBoy),
                    ),
                  ),
                  label: "Account"),
            ],
          ),
        ),
      ),
    );
  }
}








