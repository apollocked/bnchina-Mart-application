// ignore_for_file: avoid_print

import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> v = orders[0]["Data"];

   
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
            if (orders.isNotEmpty)
              Container(
                height: 225,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: "order ID ",
                                  style: TextStyle(color: textColor)),
                              TextSpan(
                                  text: orders[0]["OrderID"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(color: blackColor)),
                            ]))
                          ],
                        ),
                        Text(orders[0]["date"].toString())
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12)),
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(
                                  flex: 1,
                                ),
                                Image.asset(
                                  v[0]["imgPath"],
                                  height: 65,
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: orderpageColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12))),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          child: Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                              text: v[0]["name"],
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: "Poppins")),
                                          TextSpan(
                                              text:
                                                  " ${v[0]["quantity"].toString()} pics",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins"))
                                        ]),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
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
