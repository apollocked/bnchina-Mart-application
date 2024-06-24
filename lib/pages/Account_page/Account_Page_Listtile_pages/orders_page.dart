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
            alignment: Alignment.topCenter,
            height: 200,
            child: Image.asset(receipt),
          )
        ],
      ),
    );
  }
}
