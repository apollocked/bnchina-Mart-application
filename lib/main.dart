import 'package:minimart/pages/Authotication/register_page.dart';
import 'package:minimart/pages/layout_page.dart';
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
        home: SignUpPage());
  }
}
