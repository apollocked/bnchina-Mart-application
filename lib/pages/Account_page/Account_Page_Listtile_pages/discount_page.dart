import 'package:MiniMart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:MiniMart/utils/assets.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(children: [
            Image.asset(coupon),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Enter Coupon Code",
              style: TextStyle(color: textColor, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  hintText: "Coupon Code",
                  hintStyle: TextStyle(color: darkGreyColor)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  // the design 

                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: const Size(double.infinity, 50)),
                child: Text(
                  "Check Coupon Code",
                  style: TextStyle(color: textColor),
                ))
          ])),
    );
  }
}
