import 'package:MiniMart/pages/layout_page.dart';
import 'package:MiniMart/utils/colors.dart';
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
        home: const LayoutPage());
  }
}
