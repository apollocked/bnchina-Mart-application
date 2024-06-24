import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15),
              color: backgroundColor,
              alignment: Alignment.center,
              height: 180,
              child: Stack(
                alignment: const Alignment(0, 0),
                children: [
                  Image.asset(
                    receipt,
                    height: 120,
                  ),
                  Text(
                    "Past Orders",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
