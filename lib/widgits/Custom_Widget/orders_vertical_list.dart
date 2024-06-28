import 'package:MiniMart/utils/colors.dart';

import 'package:MiniMart/widgits/Custom_Widget/orders_card.dart';
import 'package:flutter/material.dart';

class OrdersVerticalList extends StatelessWidget {
  const OrdersVerticalList({super.key, required this.orders});
  final Map<String, dynamic> orders;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
          color: darkGreyColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Order ID  ", style: TextStyle(color: textColor)),
                    TextSpan(
                        text: "#${orders["OrderID"]}",
                        style: TextStyle(color: orderpageColor)),
                  ]))
                ],
              ),
              Text(
                orders["date"].toString(),
                style: TextStyle(color: orderpageColor),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.builder(
              itemCount: orders["Data"].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                return OrdersCard(v: orders["Data"][index]);
              },
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: "Total : "),
                TextSpan(
                  text: orders["TotalPrice"].toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'popins',
                      color: textColor),
                ),
                TextSpan(
                  text: " IQD",
                  style: TextStyle(
                      fontSize: 14, fontFamily: 'popins', color: blackColor),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
