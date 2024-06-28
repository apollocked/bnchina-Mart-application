import 'package:MiniMart/utils/colors.dart';
import 'package:flutter/material.dart';

class OrdersCard extends StatelessWidget {
  const OrdersCard({super.key, required this.v});
  final Map<String, dynamic> v;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      width: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(
            flex: 1,
          ),
          Image.asset(
            v["imgPath"],
            height: 65,
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: orderpageColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Stack(
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: v["name"],
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins")),
                    TextSpan(
                        text: " . ${v["quantity"].toString()} pics",
                        style: TextStyle(fontSize: 12, fontFamily: "Poppins"))
                  ]),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: v["price"].toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'popins',
                            color: blackColor),
                      ),
                      TextSpan(
                        text: " IQD",
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'popins',
                            color: blackColor),
                      )
                    ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
