// ignore: unused_import
import 'package:minimart/pages/Authotication/login_page.dart';
import 'package:minimart/pages/Layout_page/layout_page.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/services/storage_service.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/services/cart_service.dart';
import 'package:minimart/services/order_service.dart';
import 'package:minimart/services/notification_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize persistence services
  await StorageService().init();
  UserService().init();
  CartService().init();
  OrderService().init();
  NotificationService().init();

  runApp(const BnchinaMartApp());
}

class BnchinaMartApp extends StatelessWidget {
  const BnchinaMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BnChina Mart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.dark,
            primary: primaryColor,
            surface: surfaceColor,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: LayoutPage());
  }
}
