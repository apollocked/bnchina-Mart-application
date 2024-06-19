import 'package:apollo/pages/Basket_Page/basket_page.dart';
import 'package:apollo/pages/Account_page/account_page.dart';
import 'package:apollo/pages/Home_page/home_page.dart';
import 'package:apollo/utils/assets.dart';
import 'package:apollo/utils/colors.dart';
import 'package:apollo/widgits/Custom_Widget/custom_appbar.dart';
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
      body:
          Padding(padding: const EdgeInsets.all(10), child: pages[slectedpage]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: slectedpage,
        backgroundColor: backgroundColor,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: primaryColor),
        selectedLabelStyle:
            TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        selectedItemColor: primaryColor,
        unselectedItemColor: textColor,
        onTap: (index) {
          setState(() {
            slectedpage = index;
          });
        },
        items: [
          // ignore: deprecated_member_use
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                homeIcon,
                color: slectedpage == 0 ? primaryColor : textColor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                basketIcon
                // ignore: deprecated_member_use
                ,
                color: slectedpage == 1 ? primaryColor : textColor,
              ),
              label: "Basket"),
          const BottomNavigationBarItem(
              icon: CircleAvatar(
                maxRadius: 15,
                backgroundImage: AssetImage("assets/avatar-boy.jpg"),
              ),
              label: "account")
        ],
      ),
    );
  }
}
