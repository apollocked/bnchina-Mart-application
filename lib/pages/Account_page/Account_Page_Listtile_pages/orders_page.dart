// ignore_for_file: avoid_print

import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:MiniMart/widgits/Custom_Widget/orders_card.dart';
import 'package:MiniMart/widgits/Custom_Widget/orders_vertical_list.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
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
                )),
            orders.isNotEmpty
                ? ListView.builder(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, item) {
                      return OrdersVerticalList(
                        orders: orders[item],
                      );
                    })
                : Container(
                    alignment: Alignment.center,
                    height: 100,
                    color: darkGreyColor,
                    child: Text(
                      "You didnt order anythig yet",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
