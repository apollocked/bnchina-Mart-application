// ignore: unused_import
import 'package:minimart/pages/Layout_page/layout_page.dart';
import 'package:minimart/pages/authotication/login_page.dart';
import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BnchinaMartApp());
}

class BnchinaMartApp extends StatelessWidget {
  const BnchinaMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mini store App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
          colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
          useMaterial3: true,
        ),
        home: LoginPage());
  }
}
