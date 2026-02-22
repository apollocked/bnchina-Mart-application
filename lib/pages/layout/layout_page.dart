import 'dart:io';
import 'package:minimart/pages/cart/basket_page.dart';
import 'package:minimart/pages/account/account_page.dart';
import 'package:minimart/pages/home/home_page.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BasketPage(),
    const Accountpage(),
  ];

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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
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
            currentIndex: _selectedIndex,
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
                _selectedIndex = index;
              });
            },
            items: [
              // ignore: deprecated_member_use
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SvgPicture.asset(
                      homeIcon,
                      color: _selectedIndex == 0 ? primaryColor : subTextColor,
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
                      color: _selectedIndex == 1 ? primaryColor : subTextColor,
                      height: 22,
                    ),
                  ),
                  label: "Basket"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedIndex == 2
                              ? primaryColor
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: CircleAvatar(
                        maxRadius: 12,
                        backgroundImage: _getProfileImage(),
                        backgroundColor: surfaceColor,
                        child: _getProfileImage() == null
                            ? Icon(Icons.person,
                                size: 15,
                                color: _selectedIndex == 2
                                    ? primaryColor
                                    : subTextColor)
                            : null,
                      ),
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
