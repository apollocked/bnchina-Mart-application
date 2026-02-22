import 'package:minimart/pages/authentication/login_page.dart';
import 'package:minimart/pages/layout/layout_page.dart';
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

  runApp(const MiniMartApp());
}

class MiniMartApp extends StatelessWidget {
  const MiniMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mini Mart',
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
        home: StorageService().isLoggedIn ? LayoutPage() : LoginPage());
  }
}








